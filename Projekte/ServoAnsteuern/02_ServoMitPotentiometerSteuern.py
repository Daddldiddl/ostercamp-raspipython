# Bibliotheken laden
import machine
import time

# DutyWert fuer 0 Grad
dutyWert000Grad = 1638
# DutyWert fuer 180 Grad
dutyWert180Grad = 8192

# Nutzbarer Wertebereich von 0 - 180 Grad
dutyWerteBereich = dutyWert180Grad - dutyWert000Grad

# Pins initialisieren
ledOnBoard = machine.Pin(25, machine.Pin.OUT)
adcPoti = machine.ADC(26)

# Motor initialisieren
pwm = machine.PWM(machine.Pin(28))
pwm.freq(50)

# Bestimmt Winkel für Zeiger aus Temperatur
def bestimmeZeigerWinkelAusADC(adcWert):
    winkel = (adcWert / 65535) * 180.0
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
    # ADC auslesen und Steuerwert für Zeiger bestimmen
    adcWert = adcPoti.read_u16()
    winkel = bestimmeZeigerWinkelAusADC(adcWert)
    dutyWert = bestimmeDutyWertFuerWinkel(winkel)
    # Motor mit berechnetem DutyWert ansteuern
    pwm.duty_u16(dutyWert)
    # onboard LED toggeln und schlafen
    ledOnBoard.toggle()
    time.sleep(0.5)
    
