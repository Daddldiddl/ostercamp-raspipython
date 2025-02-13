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
def setzeLEDs(potiwert):
    # globale Variablen sichtbar machen
    global led1
    global led2
    global led3
    global led4
    global led5
    global led6
    
    # LED1 schalten
    if(potiwert>=1):
        led1.value(1)
    else:
        led1.value(0)
    # LED2 schalten
    if(potiwert>=2):
        led2.value(1)
    else:
        led2.value(0)
    # LED3 schalten
    if(potiwert>=3):
        led3.value(1)
    else:
        led3.value(0)
    # LED4 schalten
    if(potiwert>=4):
        led4.value(1)
    else:
        led4.value(0)
    # LED5 schalten
    if(potiwert>=5):
        led5.value(1)
    else:
        led5.value(0)
    # LED6 schalten
    if(potiwert>=6):
        led6.value(1)
    else:
        led6.value(0)
    
# Hauptprogramm
i=0
setzeLEDs(i)
time.sleep(1)
while True:
    led_intern.toggle()
    i=i+1
    if(i>6):
        i=0
        setzeLEDs(i)
        time.sleep(1)
    else:
        setzeLEDs(i)
    print("i = {}".format(i))
    time.sleep(0.5)