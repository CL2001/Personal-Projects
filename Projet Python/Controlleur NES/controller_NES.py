import serial
import keyboard

ser = serial.Serial('COM3', 115200)

key_map = {
    "Pressed button A": 'k',
    "Pressed button B": 'j',
    "Pressed button START": 'i',
    "Pressed button SELECT": 'u',
    "Pressed button UP": 'w',
    "Pressed button DOWN": 's',
    "Pressed button LEFT": 'a',
    "Pressed button RIGHT": 'd'
}

pressed_keys = set()

try:
    print(f"Connected to {ser.port}. Listening for button presses from Arduino...")

    while True:
        if ser.in_waiting > 0:
            line = ser.readline().decode('utf-8').strip()
        

            if line.startswith("Pressed"):
                if line in key_map:
                    key = key_map[line]
                    if key not in pressed_keys:
                        keyboard.press(key)
                        print("Pressed", key)
                        pressed_keys.add(key)

            elif line.startswith("Released"):
                if line.replace("Released", "Pressed").strip() in key_map:
                    key = key_map[line.replace("Released", "Pressed").strip()]
                    if key in pressed_keys:
                        keyboard.release(key)
                        print("Released", key)
                        pressed_keys.remove(key)

except KeyboardInterrupt:
    print("Exiting...")
    ser.close()
