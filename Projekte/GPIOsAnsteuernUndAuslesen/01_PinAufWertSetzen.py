# -------------------------------------------------------
# LED über GPIO Pin ansteuern und Wert (an/aus) setzen
# -------------------------------------------------------

# Zusatzfunktionen laden
import machine   # die für die Raspi-Ansteuerung nötigen Spezialfunktionen
import time      # Funktionen rund um Zeit - für das Warten benötigt

# GPIO 25 (onboard LED) konfigurieren und einer Variablen zuweisen
led_intern = machine.Pin(25, machine.Pin.OUT)

# Der zu setzende Wert - initial 0 (=> AUS)
pinValue = 0

# Endlosschleife (Bedingung ist immer WAHR)
while True:
    # wechselt zwischen 0 und 1 als Wert
    if (pinValue == 0): # WENN der Wert 0 ist DANN
        pinValue = 1    #     setze den Wert auf 1
    else:               # ANSONSTEN
        pinValue = 0    #     setze den Wert auf 0
    led_intern.value(pinValue) # ändere den Status des GPIO auf den Wert
    time.sleep(0.5)            # 0.5 Sekunden warten
    # Ende der Schleife - jetzt wiederholen