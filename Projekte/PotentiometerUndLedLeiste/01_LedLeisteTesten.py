# ---------------------------------------------------
# Prüft ob alle LEDs sauber angesteuert werden können 
# ---------------------------------------------------

import machine
import time

#Betriebsanzeige
led_intern = machine.Pin(25, machine.Pin.OUT)

#LED Pins
led1 = machine.Pin(1, machine.Pin.OUT)
led2 = machine.Pin(2, machine.Pin.OUT)
led3 = machine.Pin(3, machine.Pin.OUT)
led4 = machine.Pin(4, machine.Pin.OUT)
led5 = machine.Pin(5, machine.Pin.OUT)
led6 = machine.Pin(6, machine.Pin.OUT)

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

# Hauptprogramm
anzahlLEDs=0
setzeLEDs(anzahlLEDs)
time.sleep(1)
while True:
    led_intern.toggle()
    anzahlLEDs=anzahlLEDs+1
    if(anzahlLEDs>6):
        anzahlLEDs=0
    setzeLEDs(anzahlLEDs)
    print("Anzahl aktiver LEDs = {}".format(anzahlLEDs))
    time.sleep(0.5)