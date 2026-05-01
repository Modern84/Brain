---
typ: gespraechsnotiz
adressat: Reiner Woldrich
projekt: Lagerschalenhalter Lebensmittelindustrie (Volker Bens) / Drehmechanik Cavanna
stand: 2026-04-21 abends
zweck: konkrete Fehler im Fusion-Master dokumentieren für gemeinsame Aufräum-Session
---

# Fusion-Master-Cleanup — Gesprächsgrundlage für Reiner

Hallo Reiner,

heute bei der Volker-Bens-Lieferung haben wir mehrere Dinge parallel nachbearbeiten müssen — Nummern im Schriftfeld, Stücklisten-Einträge, Dateinamen. Als ich mir die CSV-Exports der 11 Bauteile angeschaut habe, war klar: Die Ursache für den Großteil der Arbeit liegt nicht am Export-Prozess, sondern im Fusion-Master selbst. Wenn wir den einmalig aufräumen, sparen wir uns bei jedem künftigen Projekt die Pflasterei.

Hier die konkreten Fundstellen — sieben Punkte, alle mit Datenbeleg aus den CSVs vom 21.04.

---

## 1. Werkstoff-Tippfehler in allen Bauteilen

In allen 11 CSV-Exports steht als Material:

```
Edelstahl 1.44.04
```

Korrekt wäre:

```
Edelstahl 1.4404
```

Der Punkt an der falschen Stelle zieht sich durch jedes Teil — Einzelteile, Schweißbaugruppen, Zusammenbauten. Das ist entweder ein Tippfehler in der Fusion-Materialdatenbank oder einmalig eingegeben und vererbt. Einmal an der Quelle fixen, und jeder künftige Export ist sauber.

## 2. Welle_V2 trägt intern den Namen "Welle_V1"

Datei: `Welle_V2 einzelteil Zeichnung.csv`

```
"1","1","BE-LS-202603-206-0","Welle_V1 einzelteil","Rundstahl","Edelstahl 1.44.04","0.37 kg"
```

Der Bauteilname sagt *Welle_V1 einzelteil*, obwohl die Datei Welle_V2 heißt. Die Masse (0.37 kg) entspricht der V2-Geometrie (V1 hat 0.49 kg), Fusion weiß intern also dass es V2 ist — nur der Name wurde beim Duplizieren nicht aktualisiert. Klassischer Copy-Paste-Fall.

Fix: Bauteil umbenennen in Fusion auf *Welle_V2 einzelteil*.

## 3. Welle_V2 Schweißbaugruppe zieht die falsche Welle

Datei: `Welle_V2 Schweisbaugruppe Zeichnung.csv`

```
Pos 1: "BE-LS-202603-206-0" "Welle_V1 einzelteil"  0.37 kg
Pos 2: "BE-LS-202603-205-0" "Scheibe_t=5"          0.02 kg
```

Folgeeffekt von #2. Sobald die V2-Welle richtig benannt ist, stimmt auch die Referenz in der Schweißbaugruppe. Gleichzeitig sollte die Nummer für das V2-Einzelteil eine eigene bekommen (nicht weiter `-206-0`, weil das die V1-Nummer ist) — Vorschlag `-207-0` oder anders, je nachdem wie du das Schema führst.

## 4. Datei "Scheibe_t=3" enthält "Scheibe_t=5"

Datei: `Scheibe_t=3 Zeichnung.csv`

```
"1","1","BE-LS-202603-205-0","Scheibe_t=5","Blech 5","Edelstahl 1.44.04","0.02 kg"
```

Dateiname sagt t=3, Teilname und Beschreibung sagen t=5 (5 mm Blech). Physisch ist es ein 5-mm-Teil. Das Teil wurde irgendwann umbenannt, aber die Bezeichnung in Fusion haftet im Dateinamen.

Fix: In Fusion entweder die Datei umbenennen auf *Scheibe_t=5* oder das Teil zurück auf t=3 benennen — wie die Scheibe tatsächlich jetzt heißen soll, weißt du besser.

## 5. Inkonsistenz mit dem `-0`-Suffix

```
Lagerhalter Zeichnung:   "BE-LS-202603-200"     (ohne -0)
Lagerschale Zeichnung:   "BE-LS-202603-201-0"   (mit -0)
```

Alle Nummern sollten nach dem Schema mit `-0` als Revisions-Suffix laufen, sonst gibt es bei zukünftigen Revisionen Kollisionen. Lagerhalter müsste `-200-0` sein.

## 6. Nummern-Kollision `-203` vs `-203-0`

```
Scheibe_t=1:               "BE-LS-202603-203-0"  (Einzelteil)
Welle_V2 Schweißbaugruppe: "BE-LS-202603-203"    (Baugruppen-Referenz im Zusammenbau)
```

Zwei physisch völlig verschiedene Teile mit fast identischer Nummer, nur das `-0` unterscheidet. Das ist in der Fertigung eine echte Fallgrube — bei schneller Kommunikation am Telefon oder in Mails wird das irgendwann verwechselt. Vorschlag: Eine der beiden Nummern komplett neu vergeben (z.B. Scheibe_t=1 auf `-011-0`, wie wir es im Volker-Bens-Register schon aufgesetzt haben).

## 7. V1-Zusammenbau enthält V2-Welle

Datei: `Zusammenbau_Lagerschalehalter V1 Zeichnung.csv`

```
Pos 4: "BE-LS-202603-204"  "Welle_V1 Schweisbaugruppe"  (V1 — OK)
Pos 8: "BE-LS-202603-203"  "Welle_V2 Schweisbaugruppe"  (V2 — ???)
```

Der V2-Zusammenbau hat nur die V2-Welle drin (Pos 4 fehlt, Pos 8 ist V2) — das passt. Der V1-Zusammenbau zeigt beide Varianten.

Mögliche Deutung:
- Bewusste Variantenübersicht auf einem Blatt für die Dokumentation
- Oder Konstruktionsfehler (Copy von V2 als V1-Ausgangspunkt, ohne V2-Pos rauszunehmen)

Das musst du wissen — je nachdem: Pos 8 aus V1-Zusammenbau rausnehmen, oder V1-Blatt als "Übersicht V1+V2" umbenennen.

---

## Einschätzung zur Arbeitsweise

Was heute passiert ist, war schnell und pragmatisch — und funktional: Du hast das bestehende PDF-Paket ausgedruckt, Mengen in Rot markiert, eingescannt, an Volker und Tomasz geschickt. Für die Fertigung reicht das: Tomasz hat die STEP-Dateien, die geben die Geometrie. Die PDFs sind Referenz, die Nummern darin sind zweitrangig wenn die 3D-Daten stimmen.

Nur: Der Aufwand auf meiner Seite, die PDFs für die Volker-Dokumentation sauber zu bekommen, ging über den Tag weil Fusion beim Export diese Baustellen mitschleppt. Die obigen 7 Punkte sind der Ursprung — nicht "Export-Einstellungen", sondern echte Inkonsistenzen im Master-Modell.

## Vorschlag

Einmal 30–45 Minuten zu zweit in Fusion reinschauen, die Master-Daten durchgehen, die 7 Punkte abhaken. Danach ist jeder künftige Export direkt lieferreif. Der Patcher den ich gebaut habe bleibt als Absicherung für Altprojekte, aber für alles was ab morgen entsteht brauchen wir ihn nicht mehr.

Wenn das für dich eine sinnvolle Investition ist, schlage ich vor wir machen das in einer ruhigen Stunde morgen oder übermorgen. Ich bereite Fusion-Stichpunkte vor, du entscheidest was in der Konstruktion geändert wird und was wie bisher bleibt.

Melde dich wann es dir passt.

Grüße, Sebastian
