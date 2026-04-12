# -------------------------------------------------------
# Fügt alles zusammen - die LEDs werden jetzt über
# das Potentiometer angesteuert und stufenweise aktiviert
# -------------------------------------------------------

import machine
import time

# Betriebsanzeige
led_intern = machine.Pin(25, machine.Pin.OUT)

# Potentiometer (analogerInput) definieren
potentiometer = machine.ADC(26)
minPoti = 250   # minimaler Wert des Potis
maxPoti = 65500 # maximaler Wert des Potis

# LED Pins
led1 = machine.Pin(15, machine.Pin.OUT)
led2 = machine.Pin(14, machine.Pin.OUT)
led3 = machine.Pin(13, machine.Pin.OUT)
led4 = machine.Pin(12, machine.Pin.OUT)
led5 = machine.Pin(11, machine.Pin.OUT)
led6 = machine.Pin(10, machine.Pin.OUT)
anzahlLEDs = 6

# Wertebereich pro LED (+1 für 0er-Stufe)
groesseStufe = (maxPoti - minPoti) / (anzahlLEDs + 1)

# sonstige globale Werte
letzterWert = 0
letzteWerte = [0]           # Liste der letzten gemessenen Werte
maxAnzahlLetzterWerte = 8 # maximale Anzahl Werte in der Liste

# Funktion um die LEDs abhängig von der übergebenen Zahl der LEDs
# zu schalten (Stufe 0-6, 0: keine leuchtet, >0: jeweilige Anzahl leuchtet)
def schalteLEDs(stufe):   
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
    
# Funktion zum Auslesen des aktuellen Wertes des Potentiometers.
# Mittelt das Ergebnis über die letzten Werte um den Wert zu stabilisieren.
def lesePotiGemittelt():
    global letzteWerte # wird ggfs. neu zugewiesen, daher global nutzen!
    neuerWert = potentiometer.read_u16()
    letzteWerte.append(neuerWert) # Wert zur Liste hinzufügen
    # Begrenzt die Liste auf die maximale Anzahl
    if (len(letzteWerte) > maxAnzahlLetzterWerte):
        letzteWerte = letzteWerte[1:] # kopiert die Liste ohne das älteste (0te) Element
    # Mittelwert der Liste der letzten Werte
    mittelWert = sum(letzteWerte) // len(letzteWerte) # abgerundeter Wert - keine Kommazahlen!
    return mittelWert

# Funktion zur Ermittelung der Anzahl der LEDs in Abhängigkeit des aktuellen Wertes
def bestimmeAnzahlLEDs(wert):
    korrigierterWert = wert - minPoti
    stufe = korrigierterWert // groesseStufe # abgerundetes Divisionsergebnis!
    if (stufe < 0):
        return 0
    elif (stufe > anzahlLEDs):
        return anzahlLEDs
    return stufe

# Hauptprogramm
while True:
    led_intern.toggle()
    aktuellerWert = lesePotiGemittelt()
    # nur ausgeben, wenn Änderung!
    if (aktuellerWert != letzterWert):
        letzterWert = aktuellerWert
        stufe = bestimmeAnzahlLEDs(aktuellerWert)
        schalteLEDs(stufe)
        print("Neuer Wert = {}, Stufe = {}".format(aktuellerWert, stufe))
    time.sleep(0.1) # 100 Millisekunden