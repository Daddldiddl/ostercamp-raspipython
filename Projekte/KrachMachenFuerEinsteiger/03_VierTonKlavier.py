# -------------------------------------------------------
# 4-Tasten 'Klavier' mit Buzzer
# -------------------------------------------------------

import machine
import time

# Betriebsanzeige auf Interner LED
led_intern = machine.Pin(25, machine.Pin.OUT)
# Tastenindikator LED auf GPIO 15
led_extern = machine.Pin(15, machine.Pin.OUT)
# PWM füer GPIO 14 initialisieren
pwm = machine.PWM(machine.Pin(14))

# Weist GPIO0 als Eingang mit internem PULLDOWN-Widerstand der Variablen taster1 zu
taster1 = machine.Pin(16, machine.Pin.IN, machine.Pin.PULL_DOWN)
taster2 = machine.Pin(17, machine.Pin.IN, machine.Pin.PULL_DOWN)
taster3 = machine.Pin(18, machine.Pin.IN, machine.Pin.PULL_DOWN)
taster4 = machine.Pin(19, machine.Pin.IN, machine.Pin.PULL_DOWN)

# initial ist der Ton aus, also Variable auf False setzen
tonAn = False
# Frequenzschritt 
frequenzSchrittweite = 200

while True:
    # Aktivitaet ueber interne LED anzeigen
    led_intern.toggle()
    value = 0
    
    # Basiswert für Frequenz aufgrund der gedrückten Tasten anpassen
    if(taster1.value() == 1):
        value += 1
    if(taster2.value() == 1):
        value += 2
    if(taster3.value() == 1):
        value += 4
    if(taster4.value() == 1):
        value += 8
        
    # wenn value groesser als 0, dann Ton anpassen!
    if(value > 0):
        # Wenn Buzzer noch nicht aktiv, dann einschalten
        if(not tonAn):
            pwm.duty_u16(500)    # Buzzer an
            tonAn = True         # Ton jetzt eingeschaltet
            print("Ton AN!")     # Info ausgeben
            led_extern.value(1)  # externe LED einschalten
        # Wert aus Tasten mit Frequenzschrittweite multiplizieren
        frequenz = value * frequenzSchrittweite
        print("Frequenz: {}hz ({}x{})".format(frequenz, value, frequenzSchrittweite))
        # Frequenz des Buzzers setzen
        pwm.freq(frequenz)
    # wenn value = 0 und Ton AN, dann ausschalten - wichtig, sonst brummt es weiter!
    elif(tonAn):
            led_extern.value(0)  # externe LED ausschalten
            pwm.duty_u16(0)      # Buzzer ausschalten
            tonAn = False        # Buzzer jetzt ausgeschaltet
            print("Ton AUS!")    # Info ausgeben
    # 50ms pausieren
    time.sleep(0.05)
