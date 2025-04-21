# ---------------------------------------------------
# Prüft das Auslesen der Potentiometerwerte 
# ---------------------------------------------------
import machine
import time

# Betriebsanzeige
led_intern = machine.Pin(25, machine.Pin.OUT)

# Potentiometer (analogerInput) definieren
potentiometer = machine.ADC(26)

# Hauptprogramm
while True:
    # Wert auslesen und in Konsole ausgeben
    aktuellerWert = potentiometer.read_u16()
    print("Neuer Wert = {}".format(aktuellerWert))
    # interne LED toggeln und halbe Sekunde warten
    led_intern.toggle()
    time.sleep(0.5) # 500 Millisekunden