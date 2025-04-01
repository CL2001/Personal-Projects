
import RPi.GPIO as GPIO
from RPLCD import CharLCD
import time

GPIO.setmode(GPIO.BCM)
pins = [26, 19, 13, 6, 5, 16]
for pin in pins:
    GPIO.setup(pin, GPIO.OUT)

lcd = CharLCD(
    pin_rs = 26, #PIN 37
    pin_e = 19, #PIN 35
    pins_data = [13, 6, 5, 16], #PINS 33, 31, 29, 36
    numbering_mode=GPIO.BCM,
    cols = 16,
    rows = 2,
    auto_linebreaks=True
)



def write_lcd(messagel1, messagel2):
    time.sleep(0.2)
    if messagel1 and len(messagel2) <= 16 and messagel2 and len(messagel2) <= 16:
        lcd.clear()
        lcd.write_string(messagel1)
        lcd.crlf()
        lcd.write_string(messagel2)
    else:
        lcd.clear()
        print("Erreur, message trop long")
    time.sleep(0.2)


def clear_lcd():
    time.sleep(0.2)
    lcd.clear()
    time.sleep(0.2)



def init_lcd():
    import RPi.GPIO as GPIO
    from RPLCD import CharLCD
    import time
    global lcd

    GPIO.setmode(GPIO.BCM)
    pins = [26, 19, 13, 6, 5, 16]
    for pin in pins:
        GPIO.setup(pin, GPIO.OUT)

    lcd = CharLCD(
        pin_rs = 26, #PIN 37
        pin_e = 19, #PIN 35
        pins_data = [13, 6, 5, 16], #PINS 33, 31, 29, 36
        numbering_mode=GPIO.BCM,
        cols = 16,
        rows = 2,
        auto_linebreaks=True
    )


#clear_lcd()
#GPIO.cleanup()