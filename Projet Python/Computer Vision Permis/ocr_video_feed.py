import cv2
import pytesseract
from PIL import Image
import time
import numpy as np

# Specify the Tesseract executable path if it's not in your system PATH
pytesseract.pytesseract.tesseract_cmd = r"C:/Program Files/Tesseract-OCR/tesseract.exe"

# Initialize webcam (0 is usually the default camera)
cap = cv2.VideoCapture(1)
if not cap.isOpened():
    print("Error: Could not open webcam.")
    exit()

print("Starting webcam capture. Press 'q' to quit.")

last_time = time.time()

while True:
    ret, frame = cap.read()
    if not ret:
        print("Error: Failed to capture frame.")
        break

    # Display the webcam frame in a window
    cv2.imshow('Webcam', frame)

    # Check if one second has passed since the last OCR operation
    current_time = time.time()
    if current_time - last_time >= 1.0:
        last_time = current_time

        # Convert the frame (BGR format) to RGB format for Pillow
        frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        pil_img = Image.fromarray(frame_rgb)

        # Extract text from the image using pytesseract
        extracted_text = pytesseract.image_to_string(pil_img)
        print("Extracted Text:")
        print(extracted_text)

    # Exit loop when 'q' key is pressed
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the webcam and close all windows
cap.release()
cv2.destroyAllWindows()
