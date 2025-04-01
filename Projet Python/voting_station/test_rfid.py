def main():
    import RPi.GPIO as GPIO
    from mfrc522 import SimpleMFRC522
    reader = SimpleMFRC522()
    try:
        id, text = reader.read()
    finally:
        GPIO.cleanup()
    return(id)

"""
if __name__ == '__main__':
    id = main()
    print(id)
"""