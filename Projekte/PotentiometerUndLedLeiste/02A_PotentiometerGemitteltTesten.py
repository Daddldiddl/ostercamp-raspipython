# ---------------------------------------------------
# Stabilisiert die Potentiometerwerte dutch Mittelung 
# ---------------------------------------------------

import machine
import time

# Betriebsanzeige
led_intern = machine.Pin(25, machine.Pin.OUT)

# Potentiometer (analogerInput) definieren
potentiometer = machine.ADC(26)

# sonstige Konfiguration und Initialisierung
alteWerte=[0] # Liste der vorangehenden Werte - für Mittelung!
maxAnzahlWerte = 8

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
    mittelWert = sum(alteWerte) // len(alteWerte) # abgerundeter Wert - keine Kommazahlen!
    return mittelWert

# Hauptprogramm
alterWert = 0
while True:
    led_intern.toggle()
    aktuellerWert = lesePotiGemittelt()
    # nur ausgeben, wenn Änderung!
    if (aktuellerWert != alterWert):
        alterWert = aktuellerWert
        print("Neuer Wert = {} aus {}".format(aktuellerWert, alteWerte))
    time.sleep(0.1) # 100 Millisekunden