from LCD1602 import LCD # import aus beigefuegter Datei!
import time

# LCD initialisieren
lcd = LCD()

# Beleuchtung LCD aktivieren
while True:
    # von 10 bis null herunterzaehlen
    for value in range(10):
        countdown = 10 - value
        # Countdown auf LCD ausgeben
        lcd.message("{}...".format(countdown))
        time.sleep(1)
        # LCD bereinigen
        lcd.clear()
    
    # Countdown vorbei, BOOM! ausgeben
    lcd.message("BOOOOOOOOOM!\nBOOOOOOOOOM!")
    time.sleep(1)
    # LCD vor naechster Runde bereinigen
    lcd.clear()
    
