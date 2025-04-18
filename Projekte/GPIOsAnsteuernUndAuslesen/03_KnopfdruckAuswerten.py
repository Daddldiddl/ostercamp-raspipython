# -------------------------------------------------------
# LED über Knopf schalten, prüft ca. 20x pro Sekunde
# -------------------------------------------------------

# Zusatzfunktionen laden
import machine   # die für die Raspi-Ansteuerung nötigen Spezialfunktionen
import time      # Funktionen rund um Zeit - für das Warten benötigt

# Weist GPIO2 als Ausgabe der Variablen led1 zu
led1 = machine.Pin(2, machine.Pin.OUT)

# Weist GPIO0 als Eingang mit internem PULLDOWN-Widerstand der Variablen taster1 zu
taster1 = machine.Pin(0, machine.Pin.IN, machine.Pin.PULL_DOWN)

# Endlosschleife
while True:
    if(taster1.value() == 1): # WENN der Taster gedrückt ist DANN
        led1.value(1)         #     schalte die LED an
    else:                     # ANSONSTEN
        led1.value(0)         #     schalte die LED aus
    time.sleep(0.05)          # schlafe 0.05 Sekunden (=50 Millisekunden)
    # Ende der Schleife - jetzt wiederholen