---
tags: [projekt, proforge5, firmware, hinweis]
date: 2026-04-18
---

# Hinweis — `prüfen/` ist leer

Ursprünglich war hier `firmware.bin` (42 KB, unklare Herkunft) abgelegt worden. Bei Mac-Inventur Phase 3 Session 2 (2026-04-18) per md5-Vergleich identifiziert:

- **md5:** `c99a2269471fcfdb147d5b6bc21e1425`
- **Identisch zu:** `ProForge-5-main/Octopus Pro Firmware/firmware.bin` aus Repo-Snapshot vom 2026-03-28
- **Header:** ARM Cortex-M (Stack `0x20020000`, Reset-Vector `0x08027018`), Bootloader-Offset `0x8000` → STM32H723 = **Octopus Pro**

→ Verschoben nach `firmware/Octopus_Pro_stock_2026-03-25_aus_Repo.bin`. Dieser Ordner kann gelöscht werden, wenn keine weiteren unklaren Binaries auftauchen.
