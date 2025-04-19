# ------------------------------------------------------
# LED per Knopf schalten
# ------------------------------------------------------

# Zusatzfunktionen laden
import machine   # Raspi Pico Funktionen
import time      # Funktionen rund um Zeit

# Weist GPIO25 als Ausgabe der Variablen ledIntern zu
ledIntern = machine.Pin(25, machine.Pin.OUT)

# Weist GPIO15 als Ausgabe der Variablen ledStatus zu
ledStatus = machine.Pin(15, machine.Pin.OUT)

# Weist GPIO0 als Eingang der Variablen taster zu
taster = machine.Pin(16, machine.Pin.IN, machine.Pin.PULL_DOWN)

alterTasterWert = 0

# Endlosschleife
while True:
    # Aktuellen Wert des Tasters auslesen
    tasterWert = taster.value()
    # Wenn sich der Wert geändert hat, dann...
    if (tasterWert != alterTasterWert):
        # In Kommandozeile ausgeben
        print("Taster jetzt {}".format(tasterWert))
        # Status LED entsprechend schalten
        ledStatus.value(tasterWert)
        # den neuen Status merken
        alterTasterWert = tasterWert
    # halbe Sekunde warten
    time.sleep(0.5)
    # onboard LED toggeln - zeigt Programmaktivität
    ledIntern.toggle()