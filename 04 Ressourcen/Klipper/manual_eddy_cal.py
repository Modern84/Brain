# Manual Eddy Calibration - single I2C reads, no bulk streaming
import logging, time

REG_DATA0_MSB = 0x00
REG_DATA0_LSB = 0x01
REG_RCOUNT0 = 0x08
REG_OFFSET0 = 0x09
REG_SETTLECOUNT0 = 0x10
REG_CLOCK_DIVIDERS0 = 0x14
REG_ERROR_CONFIG = 0x19
REG_MUX_CONFIG = 0x1B
REG_CONFIG = 0x1A
REG_DRIVE_CURRENT0 = 0x1E
REG_MANUFACTURER_ID = 0x7E
REG_DEVICE_ID = 0x7F

class ManualEddyCal:
    def __init__(self, config):
        self.printer = config.get_printer()
        gcode = self.printer.lookup_object('gcode')
        gcode.register_command('MANUAL_EDDY_CALIBRATE',
                               self.cmd_MANUAL_EDDY_CALIBRATE,
                               desc='Manual eddy calibration without bulk streaming')

    def _read_reg(self, i2c, reg):
        params = i2c.i2c_read([reg], 2)
        response = bytearray(params['response'])
        return (response[0] << 8) | response[1]

    def _write_reg(self, i2c, reg, val):
        i2c.i2c_write([reg, (val >> 8) & 0xff, val & 0xff])

    def _read_frequency(self, i2c):
        self._write_reg(i2c, REG_CONFIG, 0x001 | (1<<12) | (1<<10) | (1<<9))
        self._pause(0.05)
        msb = self._read_reg(i2c, REG_DATA0_MSB)
        lsb = self._read_reg(i2c, REG_DATA0_LSB)
        raw = ((msb & 0x0FFF) << 16) | lsb
        if raw == 0:
            return 0.0
        return (12000000.0 * raw) / (16. * 65536.)

    def _pause(self, duration):
        reactor = self.printer.get_reactor()
        eventtime = reactor.monotonic()
        reactor.pause(eventtime + duration)

    def cmd_MANUAL_EDDY_CALIBRATE(self, gcmd):
        probe_speed = gcmd.get_float('PROBE_SPEED', 1., above=0.)
        num_samples = gcmd.get_int('SAMPLES', 5, minval=1)
        max_z = gcmd.get_float('MAX_Z', 4.0, above=0.)
        step = gcmd.get_float('STEP', 0.040, above=0.)

        # Find eddy probe object by iterating all objects
        eddy = None
        for name, obj in self.printer.lookup_objects('probe_eddy_current'):
            eddy = obj
            break
        if eddy is None:
            raise gcmd.error("No probe_eddy_current found")

        ldc = eddy.sensor_helper
        i2c = ldc.i2c
        x_offset = eddy.probe_offsets.x_offset
        y_offset = eddy.probe_offsets.y_offset

        toolhead = self.printer.lookup_object('toolhead')
        kin = toolhead.get_kinematics()

        gcmd.respond_info("Manual Eddy Calibration gestartet")

        # Verify sensor while motors stopped
        toolhead.wait_moves()
        self._pause(0.5)
        manuf_id = self._read_reg(i2c, REG_MANUFACTURER_ID)
        dev_id = self._read_reg(i2c, REG_DEVICE_ID)
        gcmd.respond_info("LDC1612: manuf=0x%04x dev=0x%04x" % (manuf_id, dev_id))
        if manuf_id != 0x5449 or dev_id != 0x3055:
            raise gcmd.error("LDC1612 nicht erkannt! Verkabelung pruefen.")

        # Setup sensor
        drive_current = ldc.dccal.get_drive_current()
        rcount0 = 12000000 / (16. * 250)
        self._write_reg(i2c, REG_RCOUNT0, int(rcount0 + 0.5))
        self._write_reg(i2c, REG_OFFSET0, 0)
        self._write_reg(i2c, REG_SETTLECOUNT0, int(0.0005 * 12000000 / 16. + .5))
        self._write_reg(i2c, REG_CLOCK_DIVIDERS0, (1 << 12) | 1)
        self._write_reg(i2c, REG_ERROR_CONFIG, (0x1f << 11) | 1)
        self._write_reg(i2c, REG_MUX_CONFIG, 0x0208 | 0x01)
        self._write_reg(i2c, REG_CONFIG, 0x001 | (1<<12) | (1<<10) | (1<<9))
        self._write_reg(i2c, REG_DRIVE_CURRENT0, drive_current << 11)

        # Move sensor over current XY (adjust for probe offset)
        curpos = toolhead.get_position()
        curpos[0] -= x_offset
        curpos[1] -= y_offset
        toolhead.manual_move(curpos, probe_speed * 50)
        toolhead.wait_moves()

        # Remember reference Z (this is our "zero" point)
        ref_z = curpos[2]

        # Move UP to start position
        start_z = ref_z + max_z + 0.5
        toolhead.manual_move([curpos[0], curpos[1], start_z], probe_speed)
        toolhead.wait_moves()
        self._pause(1.0)

        num_positions = int(max_z / step) + 1
        positions = []

        gcmd.respond_info("Messe %d Positionen..." % num_positions)

        for i in range(num_positions):
            zpos = max_z - i * step
            target_z = ref_z + zpos
            toolhead.manual_move([curpos[0], curpos[1], target_z], probe_speed)
            toolhead.wait_moves()
            self._pause(0.1)

            freqs = []
            for s in range(num_samples):
                freq = self._read_frequency(i2c)
                if freq > 0:
                    freqs.append(freq)
                self._pause(0.02)

            if not freqs:
                continue

            avg_freq = sum(freqs) / len(freqs)

            toolhead.flush_step_generation()
            kin_spos = {s.get_name(): s.get_commanded_position()
                        for s in kin.get_steppers()}
            kin_pos = kin.calc_position(kin_spos)
            actual_z = kin_pos[2] - ref_z

            positions.append((actual_z, avg_freq))

            if i % 10 == 0:
                gcmd.respond_info("  Z=%.3f freq=%.1f (%d/%d)"
                                 % (actual_z, avg_freq, i+1, num_positions))

        if len(positions) < 10:
            raise gcmd.error("Zu wenig Messpunkte: %d" % len(positions))

        gcmd.respond_info("Fertig! %d Punkte." % len(positions))

        positions.sort()
        cal_contents = []
        for i, (pos, freq) in enumerate(positions):
            if not i % 3:
                cal_contents.append('\n')
            cal_contents.append("%.6f:%.3f" % (pos, freq))
            cal_contents.append(',')
        cal_contents.pop()

        configfile = self.printer.lookup_object('configfile')
        configfile.set('probe_eddy_current btt_eddy', 'calibrate',
                      ''.join(cal_contents))
        gcmd.respond_info("Kalibrierung gespeichert. SAVE_CONFIG ausfuehren!")

def load_config(config):
    return ManualEddyCal(config)
