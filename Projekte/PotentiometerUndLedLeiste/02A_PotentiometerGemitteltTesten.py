# ---------------------------------------------------
# Stabilisiert die Potentiometerwerte dutch Mittelung 
# ---------------------------------------------------

import machine
import time

# Betriebsanzeige
led_intern = machine.Pin(25, machine.Pin.OUT)

# Potentiometer (analogerInput) definieren
potentiometer = machine.ADC(26)
minPoti = 250   # minimaler Wert des Potis
maxPoti = 65500 # maximaler Wert des Potis

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
        letzteWerte = letzteWerte[1:] # kopiert die Liste ohne das erste (0te) Element
    mittelWert = sum(letzteWerte) // len(letzteWerte) # abgerundeter Wert - keine Kommazahlen!
    return mittelWert

# Hauptprogramm
alterWert = 0
while True:
    led_intern.toggle()
    aktuellerWert = lesePotiGemittelt()
    # nur ausgeben, wenn Änderung!
    if (aktuellerWert != alterWert):
        alterWert = aktuellerWert
        print("Neuer Wert = {} aus {}".format(aktuellerWert, letzteWerte))
    time.sleep(0.1) # 100 Millisekunden