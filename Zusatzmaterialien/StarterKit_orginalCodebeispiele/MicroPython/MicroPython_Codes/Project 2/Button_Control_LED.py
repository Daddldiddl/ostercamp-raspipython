import machine
import time
button = machine.Pin(16, machine.Pin.IN, machine.Pin.PULL_DOWN)
led_onboard = machine.Pin(25, machine.Pin.OUT)
led_onboard.value(0)
while True:
    if button.value() == 0:
        led_onboard.value(1)
    else :
        led_onboard.value(0)