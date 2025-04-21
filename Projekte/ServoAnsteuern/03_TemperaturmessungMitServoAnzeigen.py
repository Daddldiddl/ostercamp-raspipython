# Bibliotheken laden
import machine
import time
import math
from LCD1602 import LCD # import aus beigefuegter Datei!

# LCD initialisieren
lcd = LCD()

# DutyWert fuer 0 Grad
dutyWert000Grad = 1638
# DutyWert fuer 180 Grad
dutyWert180Grad = 8192

# Nutzbarer Wertebereich von 0 - 180 Grad
dutyWerteBereich = dutyWert180Grad - dutyWert000Grad

# Temperatur Wertebereich von 0 - 50 Grad
minimalTemperatur = -10
maximalTemperatur = 40
temperaturBereich = maximalTemperatur - minimalTemperatur

# Pins initialisieren
adcTemperatur = machine.ADC(26)
ledOnBoard = machine.Pin(25, machine.Pin.OUT)

# Motor initialisieren
pwm = machine.PWM(machine.Pin(28))
pwm.freq(50)

# Funktion, welche den ADC abfragt und als Temperatur in °C
# mit return zurueckgibt! Formel aus StarterKit-Tutorial
def bestimmeTemperaturAusADC():
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

# Bestimmt Winkel für Zeiger aus Temperatur
def bestimmeZeigerWinkelAusTemperatur(tempC):
    if(tempC > maximalTemperatur):
        tempC = maximalTemperatur
    elif(tempC < minimalTemperatur):
        tempC = minimalTemperatur
    winkel = (tempC - minimalTemperatur) / temperaturBereich * 180.0
    # Umkehrung der Zeigerrichtung (sonst wäre 0°C rechts)
    winkel = 180.0 - winkel
    return winkel

# Bestimmt den an den Motor zu übergebenden Wert anhand des Winkels
def bestimmeDutyWertFuerWinkel(winkel):
    # nur gültige Winkel akzeptieren
    if (winkel > 180):
        winkel = 180
    elif (winkel < 0):
        winkel = 0
    # Steuerwert bestimmen
    dutyBereichsWert = (winkel / 180.0) * dutyWerteBereich
    dutyWert = int(dutyBereichsWert + dutyWert000Grad)
    print("PWM DutyWert: {} (entspricht {:.2f}°)".format(dutyWert, winkel))
    return dutyWert


while True:
    # Temperatur in °C abfragen
    tempC = bestimmeTemperaturAusADC()
    # auf wieviel Grad muss der Motor fahren?
    winkel = bestimmeZeigerWinkelAusTemperatur(tempC)
    # Motorsteuerwert (Duty-Wert für PWM) bestimmen
    dutyWert = bestimmeDutyWertFuerWinkel(winkel)
    # Motor mit DutyWert ansteuern
    pwm.duty_u16(dutyWert)
    time.sleep(2.5)
    
