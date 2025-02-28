# Bibliotheken laden
from machine import Pin, PWM
from time import sleep_ms

# PWM und GPIO initialisieren
pwm = PWM(Pin(15))

# 1. Parameter: Tastgrad (Duty Cycle)
pwm.duty_u16(500)

# Die Frequenz in Herz bestimmt die Tonhöhe!
for freq in range (500, 3000, 100):
    print(freq, 'Hz')
    pwm.freq(freq)
    # Tondauer in Sekunden
    sleep_ms(300)

# PWM-Signal auf Dauer-Low (abschalten)
pwm.duty_u16(0)