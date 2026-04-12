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
minPoti = 250   # minimaler Wert des Potis
maxPoti = 65500 # maximaler Wert des Potis

# LED Pins - später werden max. so viele LEDs geschaltet
anzahlLEDs = 6

# Wertebereich pro LED (+1 für 0er-Stufe)
groesseStufe = (maxPoti - minPoti) / (anzahlLEDs + 1)

# sonstige globale Werte
letzterWert = 0
letzteWerte = [0]           # Liste der letzten gemessenen Werte
maxAnzahlLetzteWerte = 8 # maximale Anzahl Werte in der Liste

# Funktion zum Auslesen des aktuellen Wertes des Potentiometers.
# Mittelt das Ergebnis über die letzten Werte um den Wert zu stabilisieren.
def lesePotiGemittelt():
    global letzteWerte # wird ggfs. neu zugewiesen, daher global nutzen!
    neuerWert = potentiometer.read_u16()
    letzteWerte.append(neuerWert) # Wert zur Liste hinzufügen
    # Begrenzt die Liste auf die maximale Anzahl
    if (len(letzteWerte) > maxAnzahlLetzteWerte):
        letzteWerte = letzteWerte[1:] # kopiert die Liste ohne das älteste (0te) Element
    else:
        return minPoti
    mittelWert = sum(letzteWerte) // len(letzteWerte) # abgerundeter Wert - keine Kommazahlen!
    return mittelWert

# Funktion zur Ermittelung der Anzahl der LEDs in Abhängigkeit des aktuellen Wertes
def bestimmeAnzahlLEDs(wert):
    korrigierterWert = wert - minPoti
    anzahl = korrigierterWert // groesseStufe # abgerundetes Divisionsergebnis!
    if (anzahl < 0):
        return 0
    elif (anzahl > anzahlStufen):
        return anzahlStufen
    return anzahl

# Hauptprogramm
while True:
    led_intern.toggle()
    aktuellerWert = lesePotiGemittelt()
    # nur ausgeben, wenn Änderung!
    if (aktuellerWert != alterWert):
        alterWert = aktuellerWert
        anzahl = bestimmeAnzahlLEDs(aktuellerWert)
        print("Neuer Wert = {}, Anzahl = {} (Bereichsgroesse: {})".format(aktuellerWert, anzahl, groesseStufe))
    time.sleep(0.1) # 100 Millisekunden