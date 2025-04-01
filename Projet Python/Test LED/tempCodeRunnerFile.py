print("start")
import serial
import time

# Replace with the correct port (e.g., "COM3" for Windows, "/dev/ttyUSB0" for Linux)
SERIAL_PORT = "COM10"
BAUD_RATE = 9600

# Function to send colors to Arduino
def send_colors(color_array):
    with serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1) as ser:
        # Convert color array to a string format "R,G,B;R,G,B;..."
        color_string = ";".join([f"{r},{g},{b}" for r, g, b in color_array]) + "\n"
        ser.write(color_string.encode())  # Send data
        time.sleep(0.1)  # Give Arduino time to process

# Example: 64 random colors (Replace with actual values)
color_array = [(255, 0, 0)] * 32 + [(0, 255, 0)] * 32  # First 32 Red, Next 32 Green

send_colors(color_array)
print("done")