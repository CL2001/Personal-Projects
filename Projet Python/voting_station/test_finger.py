

def get_fingerprint():
    import test_screen
    import time
    import adafruit_fingerprint
    import serial
    uart = serial.Serial("/dev/ttyS0", baudrate=57600, timeout=1)
    finger = adafruit_fingerprint.Adafruit_Fingerprint(uart)
    if finger.read_templates() != adafruit_fingerprint.OK:
        raise RuntimeError("Failed to read templates")
    print("Fingerprint templates:", finger.templates)
    print("Placer votre doigt sur le sensor")
    test_screen.write_lcd("Placer votre", "doigt")
    while finger.get_image() != adafruit_fingerprint.OK:
        pass
    if finger.image_2_tz(1) != adafruit_fingerprint.OK:
        return None
    if finger.finger_search() != adafruit_fingerprint.OK:
        return None
    return finger.finger_id

def enroll_finger():
    import test_screen
    import time
    import adafruit_fingerprint
    import serial
    uart = serial.Serial("/dev/ttyS0", baudrate=57600, timeout=1)
    finger = adafruit_fingerprint.Adafruit_Fingerprint(uart)
    if finger.read_templates() != adafruit_fingerprint.OK:
        raise RuntimeError("Failed to read templates")
    print("Fingerprint templates:", finger.templates)
    location = len(finger.templates) + 1
    for fingerimg in range(1, 3):
        if fingerimg == 1:
            print("Placer votre doigt sur le lecteur")
            test_screen.write_lcd("Placer votre", "doigt")
        else:
            print("Replacer votre doigt sur le lecteur")
            test_screen.write_lcd("Replacer votre", "doigt")

        while True:
            i = finger.get_image()
            if i == adafruit_fingerprint.OK:
                break
            if i == adafruit_fingerprint.NOFINGER:
                continue
            elif i == adafruit_fingerprint.IMAGEFAIL:
                print("Erreur")
                return None
            else:
                print("Erreur")
                return None


        i = finger.image_2_tz(fingerimg)
        if i == adafruit_fingerprint.OK:
            pass
        else:
            print("Erreur")
            return None

        if fingerimg == 1:
            time.sleep(0.1)
            print("Retirer votre doigt sur le lecteur")
            test_screen.write_lcd("Retirer votre", "doigt")
            time.sleep(1)
            while i != adafruit_fingerprint.NOFINGER:
                i = finger.get_image()


    i = finger.create_model()
    if i != adafruit_fingerprint.OK:
        return None


    i = finger.store_model(location)
    if i != adafruit_fingerprint.OK:
        return None

    print("Doigt Enregistrer")
    return location

"""
print("e pour enroll. f pour find")
c = input("> ")

if c == "e":
    enroll_finger()
if c == "f":
    id =  get_fingerprint()
    if id is not None:
        print("done", id)
    else:
        print("Finger not found")
"""

