import machine
import time

poti = machine.ADC(26)

# Timing fuer 0 Grad
timing0Grad = 500000
# Timing fuer 180 Grad
timing180Grad = 2500000

# Initialisierun PWM-Generator
servo = machine.PWM(machine.Pin(16))
servo.freq(50)

def konvertiereAdcZuTiming(adcWert):
    timing = adcWert / 65535.0 * (timing180Grad - timing0Grad)
    timing = timing + timing0Grad
    return int(timing)

while True:
    wert = poti.read_u16()
    timing = konvertiereAdcZuTiming(wert)
    servo.duty_ns(timing)
    print("Der aktuelle Wert ist {} -> Servo Timing: {}".format(wert, timing))
    time.sleep(0.1)