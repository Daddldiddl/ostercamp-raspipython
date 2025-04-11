# Bibliotheken laden
import time
import machine
from machine_i2c_lcd import I2cLcd

# Festlegung LCD-Display-Größe
LCD_Anzahl_Zeilen = 2
LCD_Anzahl_Spalten = 16
LCD_Adresse = 0x27

# Festlegung I2C-Pins
I2C_Pin_SDA = 16
I2C_Pin_SCL = 17
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
        
def generiereZeichenText(zeichen, anzahl):
    text = ''
    for zaehler in range(0,anzahl):
        text = text + zeichen
    return text

# Hilfsmethode bereinigt den Screen und resettet manuelle Zeichenpositionierung
def lcdClear():
    lcd.move_to(0,0)
    lcdPrint(' ', ' ')
    lcd.clear()
    
# Display & Licht an, Zeilen bereinigen
lcdOn(True)
lcdClear()

# Balken ansteigen und abfallen lassen
messwert = 0
for runde in range(0,5):
    for phase in range(0,2):
        for schritt in range(0,LCD_Anzahl_Spalten + 1):
            balkenText = ''
            warteZeit = 0.2
            if messwert <= 0 :
                balkenText = 'LEER!'
                messwert = 0
                warteZeit = 1
            elif messwert >= LCD_Anzahl_Spalten:
                balkenText = 'VOLL!'
                messwert = LCD_Anzahl_Spalten
                warteZeit = 1
            else:
                balkenText = generiereZeichenText('o', messwert)
            infoText = "Wert: {}, {}, {}".format(runde, phase, messwert)
            lcdClear()
            lcdPrint(infoText, balkenText)
            if phase == 0:
                messwert = schritt
            else:
                messwert = LCD_Anzahl_Spalten - schritt
            time.sleep(warteZeit)
lcdPrint('Ausgabe', 'beendet!')
time.sleep(5)
lcdOn(False)
    