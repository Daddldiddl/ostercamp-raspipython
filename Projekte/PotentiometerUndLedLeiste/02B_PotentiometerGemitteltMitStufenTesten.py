# -----------------------------------------------------
# Berechnet Stufen von 0-6 (später Anzahl aktiver LEDs)
# aus den gemittelten Potentiometerwerten
# -----------------------------------------------------

import machine
import time

# Betriebsanzeige
led_intern = machine.Pin(25, machine.Pin.OUT)

# Potentiometer (analogerInput) definieren
potentiometer = machine.ADC(26)

# sonstige Konfiguration und Initialisierung
alteWerte=[0] # Liste der vorangehenden Werte - für Mittelung!
maxAnzahlWerte = 8

# Potentiometeranpassung
minPoti = 250
maxPoti = 65500
anzahlStufen = 6
groesseStufe = (maxPoti - minPoti) / (anzahlStufen + 1)

# liest den aktuellen Wert aus dem analogen Eingang des Potentiometers
def lesePoti():
    wert = potentiometer.read_u16()
    return wert

# liest das Potentiometer, mittelt aber über die letzten Werte
def lesePotiGemittelt():
    global alteWerte # wird ggfs. neu zugewiesen, daher global nutzen!
    wert = lesePoti()
    alteWerte.append(wert) # Wert zur Liste hinzufügen
    # Begrenzt die Liste auf die maximale Anzahl
    if (len(alteWerte) > maxAnzahlWerte):
        alteWerte = alteWerte[1:] # kopiert die Liste ohne das erste (0te) Element
    else:
        return minPoti
    mittelWert = sum(alteWerte) // len(alteWerte) # abgerundeter Wert - keine Kommazahlen!
    return mittelWert

# bestimmt die Stufe (Anzahl der LEDs)
def bestimmeStufe(wert):
    korrigierterWert = wert - minPoti
    stufe = korrigierterWert // groesseStufe # abgerundetes Divisionsergebnis!
    if (stufe < 0):
        return 0
    elif (stufe > anzahlStufen):
        return anzahlStufen
    return stufe

# Hauptprogramm
alterWert = 0
while True:
    led_intern.toggle()
    aktuellerWert = lesePotiGemittelt()
    # nur ausgeben, wenn Änderung!
    if (aktuellerWert != alterWert):
        alterWert = aktuellerWert
        stufe = bestimmeStufe(aktuellerWert)
        print("Neuer Wert = {}, Stufe = {}".format(aktuellerWert, stufe))
    time.sleep(0.1) # 100 Millisekunden