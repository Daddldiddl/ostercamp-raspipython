# -------------------------------------------------------
# LED über Knopf schalten
# -------------------------------------------------------

import machine
import time

# Betriebsanzeige
led_intern = machine.Pin(25, machine.Pin.OUT)

# Weist GPIO2 als Ausgabe der Variablen led1 zu
led1 = machine.Pin(2, machine.Pin.OUT)

# Weist GPIO0 als Eingang mit internem PULLDOWN-Widerstand der Variablen taster1 zu
taster1 = machine.Pin(0, machine.Pin.IN, machine.Pin.PULL_DOWN)


while True:
    led_intern.toggle()
    if(taster1.value() == 1):
        led1.value(1)
    else:
        led1.value(0)
    time.sleep(0.02)