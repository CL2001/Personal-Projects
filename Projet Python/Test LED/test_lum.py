"""
print("start")
import serial
import time

# Replace with the correct port (e.g., "COM3" for Windows, "/dev/ttyUSB0" for Linux)
SERIAL_PORT = "COM10"
BAUD_RATE = 9600

# Function to send colors to Arduino
def send_colors(color_array):
    with serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1) as ser:
        time.sleep(2)
        # Convert color array to a string format "R,G,B;R,G,B;..."
        color_string = ";".join([f"{r},{g},{b}" for r, g, b in color_array]) + "\n"
        ser.write(color_string.encode())  # Send data
        time.sleep(10)  # Give Arduino time to process

# Example: 64 random colors (Replace with actual values)
color_array = [(255, 0, 0)] * 32 + [(0, 255, 0)] * 32  # First 32 Red, Next 32 Green

send_colors(color_array)
print("done")

import serial
import time

# Serial Configuration
SERIAL_PORT = "COM10"  # "/dev/ttyUSB0" for Linux
BAUD_RATE = 9600

# Initialize Serial Connection
def initialize_serial():
    ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)
    time.sleep(2)  # Wait for Arduino to be ready
    return ser

# Send Colors Function
def send_colors(ser, color_array):
    color_string = ";".join([f"{r},{g},{b}" for r, g, b in color_array]) + "\n"
    ser.write(color_string.encode())  # Send data
    time.sleep(0.5)  # Allow Arduino to process

# Initialize Serial Connection
ser = initialize_serial()

# 10 Different Color Patterns
test_patterns = [
    [(255, 0, 0)] * 64,  # All Red
    [(0, 255, 0)] * 64,  # All Green
    [(0, 0, 255)] * 64,  # All Blue
    [(255, 255, 0)] * 64,  # All Yellow
    [(255, 0, 255)] * 64,  # All Magenta
    [(0, 255, 255)] * 64,  # All Cyan
    [(255, 255, 255)] * 64,  # All White
    [(0, 0, 0)] * 64,  # All Off
    [(i * 4, 255 - i * 4, 0) for i in range(64)],  # Gradient Red to Green
    [(i % 2 * 255, (i + 1) % 2 * 255, (i % 3) * 85) for i in range(64)]  # Alternating RGB pattern
]

# Send Each Pattern with a Delay
for i, pattern in enumerate(test_patterns):
    print(f"Sending pattern {i+1}...")
    send_colors(ser, pattern)
    #time.sleep(5)  # Wait before sending the next pattern

ser.close()  # Close Serial Connection
print("Test complete!")
"""

import serial
import time

# Serial Configuration
SERIAL_PORT = "COM10" # COM10 direct a mon pc, COM3 sur mon docking station "/dev/ttyUSB0" for Linux
BAUD_RATE = 9600

# Initialize Serial Connection
def initialize_serial():
    """Initialize serial connection with Arduino."""
    ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)
    time.sleep(2)  # Wait for Arduino to be ready
    return ser

# Send Colors Function
def send_colors(ser, colors):
    """
    Send RGB values to Arduino.
    - The array is structured as: [(bool, R, G, B), (bool, R, G, B), ...] (for 64 LEDs)
    - If the bool is False, the LED should be OFF (0,0,0).
    """
    assert len(colors) == 64, "Color array must contain 64 tuples of (bool, R, G, B)"

    # Convert (bool, R, G, B) to (R, G, B), respecting the boolean flag
    color_array = [(r, g, b) if is_on else (0, 0, 0) for is_on, r, g, b in colors]

    # Convert to formatted string
    color_string = ";".join([f"{r},{g},{b}" for r, g, b in color_array]) + "\n"
    ser.write(color_string.encode())  # Send data
    time.sleep(0.2)  # Allow Arduino to process
    print(f"Sent colors: {color_string}")

# Initialize Serial Connection
ser = initialize_serial()

# 10 Different Test Patterns


# Send Each Pattern with a Delay
for i in range(64):
    print(f"Sending pattern {i+1}...")
    colors = [(False, 255, 255, 255) for _ in range(64)]
    colors[i] = (True, 0, 255, 0)
    send_colors(ser, colors)
    time.sleep(0.1)  # Wait before sending the next pattern

ser.close()  # Close Serial Connection
print("Test complete!")
