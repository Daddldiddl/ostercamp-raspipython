import machine
import time

# Betriebsanzeige
led_intern = machine.Pin(25, machine.Pin.OUT)

# Potentiometer (analogerInput) definieren
potentiometer = machine.ADC(26)

# Laufvariablen setzen
alteWerte=[0] # Liste der vorangehenden Werte - für Mittelung!
maxAnzahlWerte = 5

def lesePoti():
    global potentiometer
    wert = potentiometer.read_u16()
    return wert

def lesePotiGemittelt():
    global alteWerte
    wert = lesePoti()
    alteWerte.append(wert)
    mittelWert = sum(alteWerte) / len(alteWerte)
    if(len(alteWerte) > maxAnzahlWerte):
        alteWerte = alteWerte[1:]
    return mittelWert



# Hauptprogramm
alterWert = 0
while True:
    led_intern.toggle()
    aktuellerWert = lesePotiGemittelt()
    # nur ausgeben, wenn Änderung!
    if(aktuellerWert != alterWert):
        alterWert = aktuellerWert
        print("Neuer Wert = {}".format(aktuellerWert))
    time.sleep(0.1)