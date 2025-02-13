# ---------------------------------------------------
# Prüft das Auslesen der Potentiometerwerte 
# ---------------------------------------------------

import machine
import time

# Betriebsanzeige
led_intern = machine.Pin(25, machine.Pin.OUT)

# Potentiometer (analogerInput) definieren
potentiometer = machine.ADC(26)

# liest den aktuellen Wert aus dem analogen Eingang des Potentiometers
def lesePoti():
    wert = potentiometer.read_u16()
    return wert

# Hauptprogramm
while True:
    led_intern.toggle()
    aktuellerWert = lesePoti()
    print("Neuer Wert = {}".format(aktuellerWert))
    time.sleep(0.5) # 500 Millisekunden