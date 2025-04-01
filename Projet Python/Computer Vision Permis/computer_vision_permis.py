import cv2
import numpy as np
import pytesseract
import os
import time
import re
from PIL import Image

# Specify the Tesseract executable path if needed
pytesseract.pytesseract.tesseract_cmd = r"C:/Program Files/Tesseract-OCR/tesseract.exe"

def order_points(pts):
    """
    Orders points in the following order: 
    top-left, top-right, bottom-right, bottom-left.
    """
    rect = np.zeros((4, 2), dtype="float32")
    s = pts.sum(axis=1)
    rect[0] = pts[np.argmin(s)]  # top-left
    rect[2] = pts[np.argmax(s)]  # bottom-right

    diff = np.diff(pts, axis=1)
    rect[1] = pts[np.argmin(diff)]  # top-right
    rect[3] = pts[np.argmax(diff)]  # bottom-left
    return rect

def detect_card(image):
    # Convert the image to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    # Apply a Gaussian blur to reduce noise
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    # Apply thresholding: adjust the threshold value if needed
    ret, thresh = cv2.threshold(blurred, 200, 255, cv2.THRESH_BINARY)
    
    # Find external contours in the thresholded image
    contours, hierarchy = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    if not contours:
        return None
    
    # Assume the card is the largest white contour in the image
    card_contour = max(contours, key=cv2.contourArea)
    
    # Get the minimum area rectangle that encloses the card contour
    rect = cv2.minAreaRect(card_contour)
    # Convert the rectangle to box points
    box = cv2.boxPoints(rect)
    box = np.int32(box)
    
    return box

def warp_card(image, ordered):
    """
    Warps the detected card to a top-down view.
    """
    (tl, tr, br, bl) = ordered
    widthA = np.linalg.norm(br - bl)
    widthB = np.linalg.norm(tr - tl)
    maxWidth = max(int(widthA), int(widthB))

    heightA = np.linalg.norm(tr - br)
    heightB = np.linalg.norm(tl - bl)
    maxHeight = max(int(heightA), int(heightB))

    dst = np.array([
        [0, 0],
        [maxWidth - 1, 0],
        [maxWidth - 1, maxHeight - 1],
        [0, maxHeight - 1]
    ], dtype="float32")

    M = cv2.getPerspectiveTransform(ordered, dst)
    warped = cv2.warpPerspective(image, M, (maxWidth, maxHeight))
    return warped

def compute_grid_points_for_warped(warped, rows, columns):
    """
    Computes grid intersection points for a warped image assuming even spacing.
    """
    h, w = warped.shape[:2]
    grid_points = np.zeros((rows+1, columns+1, 2), dtype="float32")
    cell_width = w / columns
    cell_height = h / rows
    for i in range(rows+1):
        for j in range(columns+1):
            grid_points[i, j] = (j * cell_width, i * cell_height)
    return grid_points

def draw_grid_on_image(image, grid_points, rows, columns):
    """Draws grid lines and cell numbers on the provided image using grid_points."""
    image_copy = image.copy()
    # Draw vertical grid lines
    for j in range(1, columns):
        pt1 = (int(grid_points[0, j][0]), int(grid_points[0, j][1]))
        pt2 = (int(grid_points[-1, j][0]), int(grid_points[-1, j][1]))
        cv2.line(image_copy, pt1, pt2, (0, 255, 0), 1)
    # Draw horizontal grid lines
    for i in range(1, rows):
        pt1 = (int(grid_points[i, 0][0]), int(grid_points[i, 0][1]))
        pt2 = (int(grid_points[i, -1][0]), int(grid_points[i, -1][1]))
        cv2.line(image_copy, pt1, pt2, (0, 255, 0), 1)
    # Number cells (left-to-right, top-to-bottom)
    cell_number = 1
    font = cv2.FONT_HERSHEY_SIMPLEX
    font_scale = 0.5
    thickness = 1
    for i in range(rows):
        for j in range(columns):
            pts = np.array([
                grid_points[i, j],
                grid_points[i, j+1],
                grid_points[i+1, j+1],
                grid_points[i+1, j]
            ])
            center = np.mean(pts, axis=0)
            center = (int(center[0]), int(center[1]))
            text = str(cell_number)
            (text_width, text_height), baseline = cv2.getTextSize(text, font, font_scale, thickness)
            text_org = (center[0] - text_width // 2, center[1] + text_height // 2)
            cv2.putText(image_copy, text, text_org, font, font_scale, (0, 0, 255), thickness, cv2.LINE_AA)
            cell_number += 1
    return image_copy

def create_masked_image(warped, grid_points, rows, columns, selected_cells):
    """
    Creates an image that is black everywhere except in the specified grid cells.
    """
    mask = np.zeros(warped.shape[:2], dtype="uint8")
    
    for cell in selected_cells:
        # Compute the row and column (assuming left-to-right, top-to-bottom numbering)
        row = (cell - 1) // columns
        col = (cell - 1) % columns
        pts = np.array([
            grid_points[row, col],
            grid_points[row, col+1],
            grid_points[row+1, col+1],
            grid_points[row+1, col]
        ], dtype="int32")
        cv2.fillPoly(mask, [pts], 255)
    
    mask_color = cv2.merge([mask, mask, mask])
    masked_image = cv2.bitwise_and(warped, mask_color)
    return masked_image

def process_frame(frame, rows, columns, selected_cells):
    """
    Process a single frame: detect the card, warp it, compute grid on warped image,
    create a mask for selected cells, and extract text.
    Returns:
        processed_frame: original frame with grid drawn (if card detected)
        warped: warped card image (if detected) for visualization
        masked: masked warped image with only selected cells visible
        extracted_text: OCR result from the masked image
    """
    card = detect_card(frame)
    if card is None:
        return frame, None, None, ""
    
    ordered = order_points(card)
    # Draw grid on the original frame for reference
    frame_with_grid = frame.copy()
    cv2.drawContours(frame_with_grid, [np.int32(ordered)], -1, (0, 255, 0), 3)
    
    # Warp the card to a top-down view
    warped = warp_card(frame, ordered)
    # Compute an evenly spaced grid for the warped image
    grid_points = compute_grid_points_for_warped(warped, rows, columns)
    # Draw grid on the warped image for visualization
    warped_with_grid = draw_grid_on_image(warped, grid_points, rows, columns)
    # Create a masked image that shows only the selected cells
    masked = create_masked_image(warped, grid_points, rows, columns, selected_cells)

    gray_masked = cv2.cvtColor(masked, cv2.COLOR_BGR2GRAY)
    
    # Extract text from the masked image using pytesseract
    masked_pil = Image.fromarray(gray_masked)
    extracted_text = pytesseract.image_to_string(masked_pil)
    
    return frame_with_grid, warped_with_grid, masked, extracted_text

def parse_identity(ocr_text):
    """
    Parses the OCR text and returns:
        last_name_proper, first_name_proper, year, month, day
        
    The OCR text should contain three non-empty lines (ignoring empty lines):
      - First line: last name (all-caps input)
      - Second line: first name (all-caps input)
      - Last line: date in the format YYYY-MM-DD
      
    The returned names are converted to proper case (first letter uppercase, rest lowercase).
    If the format is invalid, returns (None, None, None, None, None).
    """
    # Split the text into lines and remove empty lines
    lines = [line.strip() for line in ocr_text.splitlines() if line.strip()]
    
    if len(lines) < 3:
        print("OCR output did not have the expected format:", lines)
        return None, None, None, None, None
    
    last_name = lines[0]
    first_name = lines[1]
    date_line = lines[-1] if len(lines) >= 3 else None
    
    # Validate date format using regex (YYYY-MM-DD)
    date_pattern = r"^(\d{4})-(\d{2})-(\d{2})$"
    match = re.match(date_pattern, date_line)
    if not match:
        return None, None, None, None, None
    
    year, month, day = match.groups()
    
    # Convert the names to proper case (only first letter in uppercase)
    last_name_proper = last_name.capitalize()
    first_name_proper = first_name.capitalize()
    
    return last_name_proper, first_name_proper, year, month, day

if __name__ == '__main__':
    # Open the camera (adjust 0 or 1 as needed)
    cap = cv2.VideoCapture(1)
    
    # Grid settings for the warped card
    rows = 5
    columns = 5
    # Specify cells to extract (cells 8, 9, and 10)
    selected_cells = [7, 8, 9, 10]
    
    last_print_time = 0
    last_result = None
    same_count = 0

    try:
        while True:
            ret, frame = cap.read()
            if not ret:
                print("Failed to grab frame")
                break
            
            # Process the frame
            frame_with_grid, warped_with_grid, masked, extracted_text = process_frame(frame.copy(), rows, columns, selected_cells)
            result = parse_identity(extracted_text)
            
            # Show the different views for reference
            cv2.imshow("Camera Feed with Card Grid", frame_with_grid)
            if warped_with_grid is not None:
                cv2.imshow("Warped Card with Grid", warped_with_grid)
            if masked is not None:
                cv2.imshow("Masked (Cells 8,9,10)", masked)
            
            # Print the OCR results every 1 second if card was detected
            if time.time() - last_print_time >= 1:
                print("Extracted Text from cells {}:".format(selected_cells))
                print(extracted_text)
                print("Parsed Result:", result)
                print("-" * 30)
                
                # Check if parsed result is valid (none of the fields are None)
                if result is not None and all(val is not None for val in result):
                    # If same as last result, increase same_count, otherwise reset
                    if result == last_result:
                        same_count += 1
                    else:
                        same_count = 1
                        last_result = result
                    
                    # If the result is the same for three consecutive checks, print final result and exit
                    if same_count >= 3:
                        print("Final stable result achieved:")
                        print("Last Name: {}, First Name: {}, Date: {}-{}-{}".format(*result))
                        break
                else:
                    # Reset if the result is invalid
                    same_count = 0
                    last_result = None
                    
                last_print_time = time.time()
            
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break
        
        cap.release()
        cv2.destroyAllWindows()
    
    except Exception as e:
        print("An error occurred:", e)
        cap.release()
        cv2.destroyAllWindows()
