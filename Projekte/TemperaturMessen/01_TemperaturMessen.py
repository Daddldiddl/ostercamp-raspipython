import machine # Pico-Funktionen
import time    # Zeit-Funktionen
import math    # Mathe-Funktionen

# Pins initialisieren
adcTemperatur = machine.ADC(26)
ledOnBoard = machine.Pin(25, machine.Pin.OUT)

# Funktion, welche den ADC abfragt und als Temperatur in °C
# mit return zurueckgibt! Formel aus StarterKit-Tutorial
def getTemperatur():
    value = adcTemperatur.read_u16() # ADC lesen
    volt = value / 65535.0 * 3.3     # gemessene Spannung berechnen
    # Widerstand berechnen
    Rt = 10 * volt / (3.3 - volt)
    # Daraus die Temperatur in °K berechnen
    tempK = (1 / (1 / (273.15 + 25) + (math.log(Rt / 10)) / 3950))
    # In ganzzahlige Temperatur in °C umrechnen
    tempC = tempK - 273.15
    # Als formatierte Textzeile in Konsole ausgeben
    print("ADC: {}, V: {:.2f}, °C: {:.2f}".format(value, volt, tempC))
    return tempC

while True:
    # Temperatur mit obiger Funktion abfragen und ausgeben
    temp = getTemperatur()
    # onBoard LED toggeln als Betriebsanzeige
    ledOnBoard.toggle()
    # halbe Sekunde schlafen
    time.sleep(0.5)