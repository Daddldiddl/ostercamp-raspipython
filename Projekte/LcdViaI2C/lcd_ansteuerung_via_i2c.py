# Bibliotheken laden
import time
import machine
from machine_i2c_lcd import I2cLcd

sda = machine.Pin(20)
scl = machine.Pin(21)

# Initialisierung I2C
i2c = machine.I2C(0, sda=sda, scl=scl, freq=400000)

# Initialisierung LCD über I2C
lcd = I2cLcd(i2c, 0x27, 2, 16)
lcd.backlight_on()

def lcdPrint(line1, line2):
    lcd.clear()
    lcd.putstr(line1 + "\n" + line2)
    
def lcdOn(onOff):
    if onOff:
        lcd.backlight_on()
        lcd.display_on()
    else:
        lcd.backlight_off()
        lcd.display_off()
        
def lcdClear():
    lcd.clear()
    lcd.move_to(0,0)
    lcdPrint(' ',' ')

# Display-Inhalt löschen
lcdOn(True)
lcdClear()


# Text in Zeilen
zeile_oben  = 'Raspi-Kurs:'
zeile_unten = 'LCD-Ansteuerung'

# Display-Zeilen ausgeben
lcdPrint(zeile_oben, zeile_unten)
time.sleep(3)

# Position im Display
for zeile in range (0,2):
    for spalte in range (0,16):
        lcd.move_to(spalte, zeile)
        lcd.putstr('.')
        time.sleep(0.3)

lcdClear()

print("Hintergrundlicht AUS")

lcd.backlight_off()
lcdPrint('Backlight', 'AUS!')
time.sleep(3)

print("Hintergrundlicht an")
lcd.backlight_on()
lcdPrint('Backlight', 'AN!')
time.sleep(3)

print("Display aus")
lcdOn(False)
lcdPrint('DISPLAY', 'AUS!')
time.sleep(3)

print("Display an")
lcdOn(True)
lcdPrint('DISPLAY', 'AN!')
time.sleep(3)

lcdClear()
lcdOn(False)