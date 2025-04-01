import os
import pytesseract
from PIL import Image

# Specify the Tesseract executable path if it's not in your system PATH
pytesseract.pytesseract.tesseract_cmd = r"C:/Program Files/Tesseract-OCR/tesseract.exe"

# Determine the directory where the script is located and construct the image path
script_dir = os.path.dirname(os.path.abspath(__file__))
image_path = os.path.join(script_dir, 'permis_image.jpg')

# Open the image file using Pillow
image = Image.open(image_path)

# Use pytesseract to extract text from the image
extracted_text = pytesseract.image_to_string(image)

# Print the extracted text
print("Extracted Text:")
print(extracted_text)
