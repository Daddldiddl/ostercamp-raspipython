# -------------------------------------------------------
# LED über GPIO Pin ansteuern und Wert (an/aus) setzen
# -------------------------------------------------------

import machine
import time

# Betriebsanzeige
led_intern = machine.Pin(25, machine.Pin.OUT)

# Weist den GPIO Pin als Ausgabe der Variablen led_Pin1 zu
led_Pin1 = machine.Pin(1, machine.Pin.OUT)

pinValue = 0
while True:
    # wechselt zwischen 0 und 1 als Wert
    if (pinValue == 0):
        pinValue = 1
    else:
        pinValue = 0
    led_Pin1.value(pinValue) # setzt den Wert im Pin
    time.sleep(0.5)