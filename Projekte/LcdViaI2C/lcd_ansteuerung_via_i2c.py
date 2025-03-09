# Bibliotheken laden
import time
import machine
from machine_i2c_lcd import I2cLcd

# Festlegung LCD-Display-Größe
LCD_Anzahl_Zeilen = 2
LCD_Anzahl_Spalten = 16
LCD_Adresse = 0x27

# Festlegung I2C-Pins
I2C_Pin_SDA = 20
I2C_Pin_SCL = 21
I2C_Port = 0

# Initialisierung Pins und I2C
sda = machine.Pin(I2C_Pin_SDA)
scl = machine.Pin(I2C_Pin_SCL)
i2c = machine.I2C(I2C_Port, sda=sda, scl=scl, freq=400000)

# Initialisierung LCD über I2C
lcd = I2cLcd(i2c, LCD_Adresse, LCD_Anzahl_Zeilen, LCD_Anzahl_Spalten)

# Hilfsmethode - bereiningt Screen vor zweizeiliger Ausgabe
def lcdPrint(line1, line2):
    lcd.clear()
    lcd.putstr(line1 + "\n" + line2)

# Hilfsmethode - schaltet Display und Backlight zusammen an/aus
def lcdOn(onOff):
    if onOff:
        lcd.backlight_on()
        lcd.display_on()
    else:
        lcd.backlight_off()
        lcd.display_off()

# Hilfsmethode bereinigt den Screen und resettet manuelle Zeichenpositionierung
def lcdClear():
    lcd.move_to(0,0)
    lcdPrint(' ', ' ')
    lcd.clear()
    
# Display & Licht an, Zeilen bereinigen
lcdOn(True)
lcdClear()

# Textausgabe in Zeilen
zeile_oben  = 'Raspi-Kurs:'
zeile_unten = 'LCD-Ansteuerung'
lcdPrint(zeile_oben, zeile_unten)
time.sleep(3)

# Überschreibt beide Zeilen im Display zeichenweise
for zeile in range (0,LCD_Anzahl_Zeilen):
    for spalte in range (0,LCD_Anzahl_Spalten):
        lcd.move_to(spalte, zeile)
        lcd.putstr('.')
        time.sleep(0.3)

lcdClear()

# Hintergrundbeleuchtung ausschalten
print("Hintergrundlicht AUS")
lcd.backlight_off()
lcdPrint('Backlight', 'AUS!')
time.sleep(3)

# Hintergrundbeleuchtung einschalten
print("Hintergrundlicht an")
lcd.backlight_on()
lcdPrint('Backlight', 'AN!')
time.sleep(3)

# Display ausschalten (siehe Funktion lcdOn() oben)
print("Display aus")
lcdOn(False)
lcdPrint('DISPLAY', 'AUS!')
time.sleep(3)

# Display einschalten (siehe Funktion lcdOn() oben)
print("Display an")
lcdOn(True)
lcdPrint('DISPLAY', 'AN!')
time.sleep(3)

# Zu letzt alles wieder ausschalten
lcdClear()
lcdOn(False)