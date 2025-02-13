# --------------------------------------------------------
# LED über GPIO Pin ansteuern und Wert (an/aus) umschalten
# --------------------------------------------------------

import machine
import time

# Betriebsanzeige
led_intern = machine.Pin(25, machine.Pin.OUT)

# Weist den GPIO Pin als Ausgabe der Variablen led_Pin1 zu
led_Pin1 = machine.Pin(1, machine.Pin.OUT)

pinValue = 0
while True:
    led_Pin1.toggle() # ändert den aktuellen Wert (an/aus)
    time.sleep(0.5)