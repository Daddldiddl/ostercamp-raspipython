import machine
import time

# Betriebsanzeige
led_intern = machine.Pin(25, machine.Pin.OUT)

# Potentiometer (analogerInput) definieren
potentiometer = machine.ADC(26)

# Laufvariablen setzen
alteWerte=[0] # Liste der vorangehenden Werte - für Mittelung!
maxAnzahlWerte = 5
minPoti = 260
maxPoti = 650
stufePoti = (maxPoti - minPoti) / 6

# liest den aktuellen Wert aus dem analogen Eingang des Potentiometers
def lesePoti():
    global potentiometer
    wert = potentiometer.read_u16()
    return wert

# liest das Potentiometer, mittelt aber über die letzten Werte
def lesePotiGemittelt():
    global alteWerte
    wert = lesePoti()
    alteWerte.append(wert) # Wert zur Liste hinzufügen
    # Begrenzt die Liste auf die maximale Anzahl
    if(len(alteWerte) > maxAnzahlWerte):
        alteWerte = alteWerte[1:] # kopiert die Liste ohne das erste (0te) Element
    mittelWert = sum(alteWerte) / len(alteWerte)
    return mittelWert

# bestimmt die Stufe (Anzahl der LEDs)
def bestimmeStufe(wert):
    global stufePoti
    global minPoti
    korrigierterWert = wert - minPoti
    stufe = korrigierterWert // stufePoti
    return stufe

# Hauptprogramm
alterWert = 0
while True:
    led_intern.toggle()
    aktuellerWert = lesePotiGemittelt()
    # nur ausgeben, wenn Änderung!
    if(aktuellerWert != alterWert):
        alterWert = aktuellerWert
        print("Neuer Wert = {}, Stufe = {}".format(aktuellerWert, bestimmeStufe(aktuellerWert))
    time.sleep(0.1)