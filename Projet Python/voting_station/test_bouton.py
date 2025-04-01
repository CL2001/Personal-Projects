import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)
pin_A = 21
pin_B = 20
pin_C = 12
#pin_D = 23
GPIO.setup(pin_A, GPIO.IN)
GPIO.setup(pin_B, GPIO.IN)
GPIO.setup(pin_C, GPIO.IN)
#GPIO.setup(pin_D, GPIO.IN)

def get_vote():
    while True:
        input_A = GPIO.input(pin_A)
        input_B = GPIO.input(pin_B)
        input_C = GPIO.input(pin_C)
        #input_D = GPIO.input(pin_D)
        if input_A:
            return "A"
        if input_B:
            return "B"
        if input_C:
            return "C"
        #if input_D:
            #return "D"
        time.sleep(0.1)

def init_vote():
    import RPi.GPIO as GPIO
    GPIO.setmode(GPIO.BCM)
    pin_A = 21
    pin_B = 20
    pin_C = 12
    #pin_D = 23
    GPIO.setup(pin_A, GPIO.IN)
    GPIO.setup(pin_B, GPIO.IN)
    GPIO.setup(pin_C, GPIO.IN)
    #GPIO.setup(pin_D, GPIO.IN)
