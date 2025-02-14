# -------------------------------------------------------
# Kopie des Projekts PotentiometerUndLedLeiste.
# Das soll als Basis für die Motorsteuerung dienen.
# -------------------------------------------------------

import machine
import time

# Betriebsanzeige
led_intern = machine.Pin(25, machine.Pin.OUT)

# Potentiometer (analogerInput) definieren
potentiometer = machine.ADC(26)

# GPIO für Steuersignal
servo_pin = 28

# Motor konfigurieren
pwm = machine.PWM(machine.Pin(servo_pin))
pwm.freq(50)
steuerwert_0grad = 1638
steuerwert_180grad = 8192

#LED Pins
led1 = machine.Pin(1, machine.Pin.OUT)
led2 = machine.Pin(2, machine.Pin.OUT)
led3 = machine.Pin(3, machine.Pin.OUT)
led4 = machine.Pin(4, machine.Pin.OUT)
led5 = machine.Pin(5, machine.Pin.OUT)
led6 = machine.Pin(6, machine.Pin.OUT)

# sonstige Konfiguration und Initialisierung
alteWerte=[0] # Liste der vorangehenden Werte - für Mittelung!
maxAnzahlAlterWerte = 8

# Potentiometeranpassung
minPoti = 250
maxPoti = 65500
anzahlStufen = 6
groesseStufe = (maxPoti - minPoti) / (anzahlStufen + 1)

# Schaltet die LEDs abhängig vom übergebenen Wert (0-6)
def setzeLEDs(stufe):   
    # LED1 schalten
    if(stufe>=1):
        led1.value(1)
    else:
        led1.value(0)
    # LED2 schalten
    if(stufe>=2):
        led2.value(1)
    else:
        led2.value(0)
    # LED3 schalten
    if(stufe>=3):
        led3.value(1)
    else:
        led3.value(0)
    # LED4 schalten
    if(stufe>=4):
        led4.value(1)
    else:
        led4.value(0)
    # LED5 schalten
    if(stufe>=5):
        led5.value(1)
    else:
        led5.value(0)
    # LED6 schalten
    if(stufe>=6):
        led6.value(1)
    else:
        led6.value(0)
    
# liest den aktuellen Wert aus dem analogen Eingang des Potentiometers
def lesePoti():
    wert = potentiometer.read_u16()
    return wert

# liest das Potentiometer, mittelt aber über die letzten Werte
def lesePotiGemittelt():
    global alteWerte # wird ggfs. neu zugewiesen, daher global nutzen!
    wert = lesePoti()
    alteWerte.append(wert) # Wert zur Liste hinzufügen
    # Begrenzt die Liste auf die maximale Anzahl
    if (len(alteWerte) > maxAnzahlAlterWerte):
        alteWerte = alteWerte[1:] # kopiert die Liste ohne das erste (0te) Element
    else:
        return minPoti
    mittelWert = sum(alteWerte) // len(alteWerte) # abgerundeter Wert - keine Kommazahlen!
    return mittelWert

# bestimmt die Stufe (Anzahl der LEDs)
def bestimmeStufe(wert):
    korrigierterWert = wert - minPoti
    stufe = korrigierterWert // groesseStufe # abgerundetes Divisionsergebnis!
    if (stufe < 0):
        return 0
    elif (stufe > anzahlStufen):
        return anzahlStufen
    return stufe

# bestimmt den Wert für die Motoransteuerung
def bestimmeSteuerwert(wert):
    steuerFaktor = (wert - minPoti) / (maxPoti - minPoti)
    steuerwert = (steuerwert_180grad - steuerwert_0grad) * steuerFaktor + steuerwert_0grad
    if (steuerwert < steuerwert_0grad):
        return steuerwert_0grad
    elif (steuerwert > steuerwert_180grad):
        return steuerwert_180grad
    return int(steuerwert)

# Hauptprogramm
alterWert = 0
zaehler = 100
while zaehler > 0:
    led_intern.toggle()
    aktuellerWert = lesePotiGemittelt()
    # nur ausgeben, wenn Änderung!
    if (aktuellerWert != alterWert):
        alterWert = aktuellerWert
        stufe = bestimmeStufe(aktuellerWert)
        setzeLEDs(stufe)
        steuerwert = bestimmeSteuerwert(aktuellerWert)
        pwm.duty_u16(steuerwert)
        print("Neuer Wert = {}, Stufe = {}, Steuerwert = {}".format(aktuellerWert, stufe, steuerwert))
    time.sleep(0.5) # 100 Millisekunden
    zaehler = zaehler - 1
# Bereinigen, LEDs ausschalten, Motorsteuerung deinitialisieren
setzeLEDs(0)
led_intern.value(0)
pwm.deinit()
