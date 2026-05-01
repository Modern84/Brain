---
tags: [ressource, klipper, proforge5, stepper-umbau, evaluation]
status: aktiv
date: 2026-04-28
---

# Servo-Stepper-Umbau-Bewertung — Zweit-Meinung zu Claude.ais Empfehlung

Kritische Gegenprüfung der Claude.ai-Empfehlung „Heute KEIN Stepper-Umbau, BEC-Pfad zuerst (80 %)". Ergebnis vorab: BEC-zuerst ist im Kern richtig, die 80 %-Zahl ist nicht belegbar, drei der Stepper-Bauraum-Annahmen halten, eine Stepper-Option (Closed-Loop NEMA 11) fehlt im Vergleich, und eine echte vierte Option (Bus-Servo mit Strom-Cap, FEETECH STS3215) ist sauber ignoriert. Substanz-Empfehlung am Ende.

## Datenlage verifiziert

**MG996R-Bauraum.** Datasheet bestätigt 40,7 × 19,7 × 42,9 mm ([HandsOnTec PDF](https://www.handsontec.com/dataspecs/motor_fan/MG996R.pdf), [components101](https://components101.com/motors/mg996r-servo-motor-datasheet)). Claude.ais „~42 mm axial" stimmt. ✅

**LDO-28STH32-0674APG14 (Jubilee-Stepper).** NEMA 11, 32 mm Motorkörper + 36 mm Getriebebox, 13,76:1 Untersetzung, 0,67 A, 0,6 kgf·cm Haltedrehmoment am Motor (= ~8 kgf·cm an der Ausgangswelle nach Untersetzung), 6 mm D-Welle ([Filastruder](https://www.filastruder.com/products/ldo-stepper-motor-set-for-jubilee), [LDO 28mm Hybrid](https://ldomotors.com/products/show/28mm-hybrid-stepper-series)). **Gesamtlänge ohne Welle: 32 + 36 = 68 mm.** Claude.ais Angabe stimmt. ✅

**NEMA 8 + 1:50 Planetengetriebe (Option B).** StepperOnline EGS8-G50 Getriebebox: **48 mm Länge** plus Motorlänge. Typischer NEMA-8-Motor (8HS15-0604S) ist 38 mm lang, also Gesamtlänge ≥ 86 mm ([StepperOnline EGS8-G50](https://www.omc-stepperonline.com/eg-series-planetary-gearbox-gear-ratio-50-1-backlash-20arc-min-for-nema-8-stepper-motor-egs8-g50)). **Claude.ais „~45 mm" für NEMA 8 + 1:50 ist falsch — Faktor 2 daneben.** ❌ Drehmoment am NEMA-8-Motor selbst ist außerdem nur 0,04 Nm = ~0,4 kgf·cm, mal 1:50 ergibt ~20 kgf·cm theoretisch, real nach Wirkungsgrad ~15 kgf·cm. Drehmoment ist also OK, **Bauraum aber deutlich enger als behauptet**.

**E3D Servo→Stepper-Story.** Direkt vom E3D-Blog 2019-04-18 verifiziert: alter Servo „struggling to exceed 60.000 tool changes", neuer Stepper „can easily surpass 400.000 cycles", nach 400 k kein erkennbarer Verschleiß ([E3D Blog](https://e3d-online.com/blogs/news/toolchanger-the-update-youve-all-been-waiting-for)). **Die 1,5 M-Zahl steht im E3D-Blog nicht direkt** — sie taucht in Marketing-Snippets auf, aber im Original-Post werden 400 k als verifiziertes Maximum genannt. 🟡 Claude.ais „60 k → 400 k+ → 1,5 M" ist halb belegt: 60 k und 400 k sind solide, 1,5 M ist Hersteller-Rating ohne im Blog dokumentierten Test.

**Octopus Pro freie Slots.** BTT-Wiki und GitHub bestätigen: 8 Treiber-Slots, 9 Treiber-Outputs (Z dual). Bei ProForge 5 belegt: X, Y, Z (4×), Extruder = 7. **Bleiben 1 freier Slot bei Z-dual-Konfig oder 2 wenn Z auf 2 Treiber zusammengelegt** ([BTT Wiki Octopus Pro](https://global.bttwiki.com/Octopus%20Pro.html), [Octopus Pro GitHub](https://github.com/bigtreetech/BIGTREETECH-OCTOPUS-Pro)). Claude.ais „2-3 freie Slots" ist optimistisch — realistisch **1 freier Slot**, ggf. 2 nach Konfig-Umbau. 🟡

**ProForge 4 Stage 04 Doku öffentlich?** Makertech-Dozuki existiert ([makertech-3d.dozuki.com](https://makertech-3d.dozuki.com/)). „Stage 04: Tool Carriage" gibt es als Guide für die DSE-Variante (Dual Switching Hotend) und für ProForge 2S. **Eine ProForge-4-spezifische Stage-04-Doku ist in der Suche nicht eindeutig auffindbar** — es gibt überlappende Stages über mehrere Modelle. ([DSE Stage 04 Tool Carriage](https://makertech-3d.dozuki.com/Guide/DSE+Only+-+Stage+04:+Tool+Carriage/68)). Claude.ais Aussage „ProForge 4 Stage 04 Doku mechanisch auf ProForge 5 anwendbar" ist **nicht direkt verifizierbar** — die Stages sind teils auf andere Modelle gemünzt, Übertragbarkeit muss mechanisch geprüft werden, nicht angenommen. 🟡

**GitHub Makertech3D/ProForge-5 leer?** Repository existiert, hat 16 Commits, enthält **3D Printed Parts (STL), Config Files, Enclosure Panels, Octopus Pro Firmware, Slicer Configs** ([GitHub Makertech3D/ProForge-5](https://github.com/Makertech3D/ProForge-5/)). **Keine STEP/CAD-Quelldateien für die Lock-Mechanik.** Claude.ais „faktisch leer (nur README + LICENSE)" ist falsch — das Repo hat mehr, aber **CAD-Quellen fehlen tatsächlich**. ❌ in Claude.ais Formulierung, ✅ in der Konsequenz (kein CAD).

## Stepper-Optionen erweitert

Drei Optionen von Claude.ai (NEMA 17 Pancake, NEMA 8 + 1:50, externer Stepper mit GT2). **Eine wesentliche Option fehlt: Closed-Loop-NEMA-11.** TSM11Q-1RM (StepSERVO, integrierter Treiber, Step/Dir-Eingang) und vergleichbare ESS11-01 (24 V, 5000 CPR Encoder, 7,4 N·cm) sind kompakter als NEMA 17 und liefern Drehmoment mit Encoder-Feedback ([Mclennan TSM11](https://www.mclennan.co.uk/product/tsm11-nema-11-integrated-stepservo), [Oyostepper ESS11-01](https://www.oyostepper.com/goods-834-74Ncm-105ozin-Nema-11-Integrated-Closed-Loop-Stepper-Servo-Motor-24VDC-5000CPR-ESS.html)). Praktisch heißt das: Step/Dir am Octopus, Treiber im Motor, kein freier Octopus-Slot nötig. **Das ist relevant, weil Octopus Pro real nur ~1 Slot frei hat.**

Nicht relevant nach Recherche: BLDC mit Encoder (Maxon/Faulhaber) — Preis-Klasse 200–500 €, nicht verhältnismäßig. Hybrid-Servo Leadshine HBS — Bauraum NEMA 17+ und Treiber extern, kein Vorteil gegenüber Pancake-NEMA-17. Spezielle Toolchanger-Stepper aus Voron/Jubilee: LDO-28STH32-0674APG14 ist genau der Jubilee-Pfad und ist in Claude.ais Liste implizit als Option-B-Pendant enthalten — die NEMA-11-Variante mit 13,76:1 ist kompakter als NEMA-8 + 1:50 (68 mm vs. ≥86 mm) und hat das bewährte Drehmoment-Profil aus dem Jubilee-Einsatz. **Reine Direkt-Drive ohne Getriebe mit >15 kgf·cm Holding-Torque in NEMA 8/11**: existiert nicht in dieser Klasse, da müsste man auf NEMA 17 zurück. Bestätigt Claude.ais Logik.

**Option B-Plus (neu): LDO-28STH32-0674APG14 direkt, NEMA 11 + 13,76:1, 68 mm Gesamtlänge.** Sollte in der Optionsliste statt oder neben NEMA 8 + 1:50 stehen. Bewährt, dokumentiert, lieferbar bei Filastruder/HighTemp3D. ✅

## BEC-Erfolgs-Schätzung

Claude.ai schätzt 80 %. Recherche-Befund: **kein einziger dokumentierter Klipper-/Voron-/Jubilee-Thread**, in dem genau das Pattern „separater BEC für Servo löst CAN-Crash am EBB36" mit Vorher/Nachher belegt ist. Es gibt das Gegenstück bestätigt — **EMI vom Toolhead-Treiber koppelt in CAN** ([BTT EBB Issue #172](https://github.com/bigtreetech/EBB/issues/172)) — und das Pattern „Servo-Move triggert MCU-Shutdown" ist mehrfach beschrieben ([Klipper Discourse PWM problem with servos](https://klipper.discourse.group/t/pwm-problem-with-servos/6108), [MCU timeout during servo move](https://klipper.discourse.group/t/mcu-timeout-during-servo-move/3380)). **Lösungs-Threads enden meistens mit „separat versorgen" als Empfehlung, nicht mit Verifikation.**

Heißt: Die theoretische Begründung ist solide (Industrie-Pattern „Power-Domains trennen", Voron-Wissen „EBB-5V ist die Schwachstelle bei Toolhead-Lasten"), aber die empirische Quote „80 % BEC löst CAN-Crash" ist **aus dem Bauch geschätzt, nicht belegbar**.

**Ehrliche Spannweite: 50–75 %.** Begründung: Die Root-Cause-Hypothese (Stromspike auf gemeinsamer 5V-Schiene) ist die wahrscheinlichste, aber nicht die einzige. Mögliche Resterklärungen, falls BEC nicht reicht: (a) HF-Bürstenrauschen koppelt direkt über CAN-Twisted-Pair (Option 4b/Schirmung), (b) loser 120 Ω-Jumper (Option 4a — kostet 5 Min), (c) Spike koppelt über das PWM-Signal selbst ins MCU-GPIO und nicht über die Versorgung. Die 80 % wären gerechtfertigt, wenn (b) im Vorfeld ausgeschlossen ist. **Wenn 4a + BEC parallel kommen, akzeptiere ich 75–80 %. BEC allein ohne Termination-Check: 50–65 %.**

## Vierte Option

**Ja, gefunden: Servo-Tausch auf FEETECH STS3215** (oder vergleichbarer Bus-Servo mit dokumentiertem Strom-Cap). 19 kg·cm @ 7,4 V, **Magnetencoder mit Positions-Feedback, Strom-/Last-/Temperatur-Feedback über TTL-Bus, einstellbare Überstrom-Schwelle** ([FEETECH STS3215](https://www.feetechrc.com/2020-05-13_56655.html), [Amazon RCmall STS3215](https://www.amazon.com/RCmall-Continuous-Programmable-SO-ARM100-Controller/dp/B0F87XY6F2)). Preis 25–35 €, Bauraum analog Standard-Servo (40 × 20 × 40 mm-Klasse).

**Warum interessant:** Der Crash-Pfad ist Stromspike beim Anlauf gegen Federspannung. STS3215 begrenzt seinen Strom **selbst hardwareseitig**. Das eliminiert die Root-Cause direkt, ohne separate Versorgung, ohne Stepper-Umbau. Plug-Bauraum nahezu identisch zum MG996R.

**Warum nicht Top-Empfehlung:** Klipper hat **kein Standard-Modul** für TTL-Bus-Servos. Ansteuerung müsste über externen UART (z. B. EBB-UART-Pin) und ein eigenes Macro-Skript laufen oder über einen kleinen Mikrocontroller-Adapter. Das ist Bastel-Arbeit — kein Show-Stopper, aber Zeit-Investment vergleichbar mit BEC-Pfad. Quellenlage für Klipper-STS3215-Integration: keine produktive Doku gefunden, nur Robotik-Projekte (LeRobot/SO-ARM100) auf Python-Ebene.

Andere geprüfte vierte Optionen, **abgelehnt**:
- **Bistabiler Solenoid Push-Pull**: Holding-Force kommerzieller Latching-Solenoide bis ~30–36 N, das ist für gefederten Lock-Mechanismus mit Klemm-Kraft eher knapp ([Geeplus Latching Solenoids](https://www.geeplus.com/latching-solenoids/), [Transmotec Latching](https://www.transmotec.com/product-category/solenoids/latching/)). Geometrie passt nicht zur Cam-Shaft-Topologie der ProForge 5 — wäre Re-Design der Lock-Mechanik. Nicht verhältnismäßig.
- **Bowden-Servo (räumlich versetzt)**: Cam-Shaft über Bowden oder Mini-Welle — mechanische Reibung + Spiel = neue Probleme, unklarer Gewinn gegen die EMI-Quelle.
- **Federspannung reduzieren**: Adressiert das Symptom (Strompeak), aber gefährdet die Lock-Funktion (Tool-Halt). Nicht ohne genaue Messung der Vorspannung empfehlenswert.
- **Manueller Lock**: Pragmatisch, aber widerspricht dem Sinn eines Toolchangers für MThreeD.io-Produktion. Notfall-Fallback, keine Lösung.

## Wartezeit-Argument

Claude.ai: BEC 24–48 h vs. Stepper 5–10 Werktage + 2–3 Wochenenden Reverse-Engineering Carriage-Bracket. Trägt das?

**Ja, größtenteils.** Reverse-Engineering einer Carriage-Bracket-Baugruppe ohne CAD-Quellen, mit Caliper, Federspannungs-Messung, Lock-Mechanik-Verständnis und Iteration im Druck/Fit ist **realistisch 2–4 Wochenenden** für jemanden auf Mo's Niveau (Konstrukteur, Fusion-routiniert) — und das ist optimistisch, weil Lock-Mechanik gegen Federn iterativ getestet werden muss. Das Argument trägt also.

**Aber:** Es gibt einen Mittelweg, den Claude.ai nicht anbietet. **Mo kann Makertech direkt nach STEP-Files für die Carriage-Plate fragen** (info@makertech3d.com), ggf. unter Nennung des MThreeD.io-Kontexts. Das kostet eine Mail und zwei Tage Wartezeit. Bei positiver Antwort fällt das Reverse-Engineering komplett weg. Bei negativer Antwort weiß man, woran man ist, ohne Caliper-Stunden investiert zu haben. **Das gehört in Tag 1 parallel zur BEC-Bestellung, nicht „falls Stepper-Pfad nötig".**

Anti-Vertagungs-Regel im Brain explizit nicht gefunden. Aber: BEC-Pfad ist kein Vertagen, sondern reversible Diagnose-Investition mit Lerngewinn (siehe Option 1 in [[Servo-EMI-Mitigation-Strategien]]). Wenn BEC scheitert, weiß Mo, dass das Problem **nicht** auf der 5V-Schiene liegt — das ist diagnostisch wertvoll, nicht verlorene Zeit.

## Community-Recherche

- **ProForge 5 Servo→Stepper-Umbau dokumentiert:** **Nichts gefunden.** Reddit, RepRap-Forum, Printables, Thingiverse — keine spezifische ProForge-5-Stepper-Conversion. Suchen mit „ProForge 5 servo stepper conversion" liefern nur die E3D-Toolchanger-Story und allgemeine Diskussionen.
- **ProForge 5 CAD reverse-engineered öffentlich:** **Nicht gefunden.** Im offiziellen GitHub-Repo nur STL für 3D-gedruckte Teile, keine CAD-Quellen für die Carriage-Plate ([GitHub Makertech3D/ProForge-5](https://github.com/Makertech3D/ProForge-5/)).
- **Makertech-Roadmap (Stepper-Variante):** **Nicht in der Suche auffindbar.** Keine öffentliche Ankündigung, kein Blog-Post, keine Twitter/X-Spur in den Top-Treffern. Das heißt nicht, dass keine geplant ist — heißt nur, sie ist nicht öffentlich kommuniziert.
- **Discord-Suche:** Discord ist **nicht öffentlich indexierbar** ohne aktive Mitgliedschaft im Server. Treffer dort sind über Web-Suche prinzipiell nicht vollständig erfassbar. Das ehrlich als Lücke.
- **Direkt-Anfrage an Hersteller (STEP-Files):** Keine Quelle die belegt, dass Makertech CAD an Endkunden rausgibt. Aber auch keine, die das ausschließt. **Nur ein Versuch klärt das.**

## Schluss-Empfehlung

**BEC-Pfad bestellen, aber mit Modifikationen am Plan.** Konkret in dieser Reihenfolge:

1. **Heute:** Hobbywing UBEC 5A Air V2 bestellen (15–25 €, [Hobbywing](https://www.hobbywing.com/en/products/ubec-5a93)). Parallel **eine Mail an info@makertech3d.com** mit Bitte um STEP/CAD-Files der Carriage-Plate-Baugruppe für den Toolchanger-Lock-Bereich (Begründung: MThreeD.io-Produktionseinsatz, Stepper-Variante als Fallback evaluieren).
2. **Vor BEC-Einbau:** Termination-Check mit Multimeter (5 Min, Kosten 0 €) — dokumentierter Crash-Auslöser laut Voron-Community ([Klipper Discourse bytes_retransmit](https://klipper.discourse.group/t/bytes-retransmit-increases-and-transition-to-shutdown-state-mcu/25386)). **Das gehört vor jeden Hardware-Kauf.**
3. **BEC einbauen + Test.** Erfolgs-Spannweite ehrlich 50–75 % (BEC allein) bzw. 75–80 % (BEC + verifizierte Termination). Nicht 80 % aus dem Bauch.
4. **Falls BEC scheitert:** Stepper-Pfad mit **LDO-28STH32-0674APG14 (NEMA 11 + 13,76:1, 68 mm)** als primärer Kandidat, nicht NEMA 8 + 1:50 (wegen Bauraum-Realität ≥86 mm). Closed-Loop-NEMA-11 (TSM11Q-Klasse) als Backup, falls Octopus-Slots tatsächlich knapp werden. FEETECH STS3215 als Wildcard, nur falls Mo Lust auf TTL-Bus-Integration hat.

**Top-Aktion heute: BEC bestellen + Makertech-Mail schreiben + Termination-Check vorbereiten.**

Klare Begründung warum nicht Stepper-zuerst: Reversibilität + Diagnose-Wert sprechen für BEC. Ein gescheiterter BEC-Test kostet 25 € und 2 h, liefert aber harte Information über die Crash-Topologie. Ein erfolgreicher Stepper-Umbau ohne BEC-Test lässt offen, was eigentlich kaputt war — und der nächste Servo-ähnliche Spike (Heizpatrone, Lüfter-Anlauf) crasht das System wieder.

**Klare Korrektur an Claude.ai:** Die 80 % sind nicht belegt, das gehört im ProForge5-Build-Doc als „Hypothese, geschätzt 50–80 % je nach Termination-Check" vermerkt, nicht als belastbare Zahl.

## Verknüpfungen

- [[Servo-EMI-Mitigation]] — Software-Mitigation und Crash-Pfad-Analyse
- [[Servo-EMI-Mitigation-Strategien]] — Hardware-Optionen 1–6 mit Quellen
- [[02 Projekte/ProForge5 Build/ProForge5 Build]] — Projektkontext
- [[05 Daily Notes/2026-04-27]] — Marathon-Saga, Verifikationslauf
