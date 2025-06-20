# Bibliotheken laden
import machine
from pirc522 import RFID
from time import sleep
reader = RFID()
keys = list()
key_read = True
print('[press ctrl+c to end the script]')

led = machine.Pin(15, machine.Pin.OUT) # aus Modul machine

reader = RFID(bus=0, device=1, pin_rst=17, pin_irq=19)

try:
    while True:
        reader.wait_for_tag()
        error, tag_type = reader.request()
        if not error:
            error, uid = reader.anticoll()
            if not error:
                if len(keys) > 0:
                    for key in keys:
                        if key == uid:
                            key_read = False
                            break
            else:
                key_read = True
        else:
            key_read = True
        if key_read:
            keys.append(uid)
            print('New tag detected! UID: {} ({})'.format(uid, tag_type))
            reader.stop_crypto() # always call this when done working key_read = False
        else:
            print('Already detected that tag!')
        sleep(0.1)
# Scavenging work after the end of the program
except KeyboardInterrupt:
    print('Script end!')
finally:
    reader.cleanup() # Calls GPIO cleanup