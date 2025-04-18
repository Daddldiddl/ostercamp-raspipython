# -------------------------------------------------------
# LED über GPIO Pin ansteuern und Wert umschalten
# -------------------------------------------------------

# Zusatzfunktionen laden
import machine   # die für die Raspi-Ansteuerung nötigen Spezialfunktionen
import time      # Funktionen rund um Zeit - für das Warten benötigt

# GPIO 25 (onboard LED) konfigurieren und einer Variablen zuweisen
led_intern = machine.Pin(25, machine.Pin.OUT)

# Endlosschleife (Bedingung ist immer WAHR)
while True:
    led_intern.toggle() # schalte den Status des GPIO um (AN-AUS oder AUS->AN)
    time.sleep(0.5)     # 0.5 Sekunden warten
    # Ende der Schleife - jetzt wiederholen