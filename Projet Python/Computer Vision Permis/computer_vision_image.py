import cv2
import numpy as np
import os
import pytesseract
from PIL import Image
import re

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
    # Apply thresholding; adjust the threshold value if needed
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
            # Determine cell center from its corners
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
    
    :param warped: Warped (top-down) image.
    :param rows: Number of grid rows.
    :param columns: Number of grid columns.
    :return: A (rows+1) x (columns+1) array of grid points.
    """
    h, w = warped.shape[:2]
    grid_points = np.zeros((rows+1, columns+1, 2), dtype="float32")
    cell_width = w / columns
    cell_height = h / rows
    for i in range(rows+1):
        for j in range(columns+1):
            grid_points[i, j] = (j * cell_width, i * cell_height)
    return grid_points

def create_masked_image(warped, grid_points, rows, columns, selected_cells):
    """
    Creates an image that is black everywhere except in the specified grid cells.
    
    :param warped: The top-down view of the card image.
    :param grid_points: Grid intersection points for the warped image.
    :param rows: Number of rows in the grid.
    :param columns: Number of columns in the grid.
    :param selected_cells: List of cell numbers (1-indexed) to keep.
    :return: A masked image where only the selected cells show their original content.
    """
    mask = np.zeros(warped.shape[:2], dtype="uint8")
    
    for cell in selected_cells:
        # Compute the row and column (assuming left-to-right, top-to-bottom numbering)
        row = (cell - 1) // columns
        col = (cell - 1) % columns
        # Get the cell polygon corners in the warped image
        pts = np.array([
            grid_points[row, col],
            grid_points[row, col+1],
            grid_points[row+1, col+1],
            grid_points[row+1, col]
        ], dtype="int32")
        # Fill the polygon for this cell in the mask
        cv2.fillPoly(mask, [pts], 255)
    
    # Create a 3-channel version of the mask and apply it
    mask_color = cv2.merge([mask, mask, mask])
    masked_image = cv2.bitwise_and(warped, mask_color)
    return masked_image



def parse_identity(ocr_text):
    """
    Parses the OCR text and returns:
        last_name_proper, first_name_proper, year, month, day
        
    The OCR text should contain three non-empty lines (ignoring empty lines):
      - First line: last name (all-caps input)
      - Second line: first name (all-caps input)
      - Third line: date in the format YYYY-MM-DD
      
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
    date_line = lines[-1]
    
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
    # Adjust the path to your image accordingly
    script_dir = os.path.dirname(os.path.abspath(__file__))
    image_path = os.path.join(script_dir, 'permis_image.jpg')
    image = cv2.imread(image_path)
    
    if image is None:
        print("Image not found at the provided path.")
    else:
        # Define grid dimensions (for the warped card)
        rows = 5
        columns = 5

        # Specify which cells to extract text from (only these will remain visible)
        selected_cells = [7, 8, 9, 10]

        # Detect the card and get ordered points
        card = detect_card(image)
        if card is None:
            print("No card detected.")
            exit()
        ordered = order_points(card)
        
        # Warp the card to a top-down view
        warped = warp_card(image, ordered)
        
        # Compute a grid for the warped image
        grid_points = compute_grid_points_for_warped(warped, rows, columns)
        
        # (Optional) Draw the grid and cell numbers on a copy of the warped image for reference
        warped_with_grid = draw_grid_on_image(warped, grid_points, rows, columns)
        
        # Create a masked version that shows only the selected cells
        masked = create_masked_image(warped, grid_points, rows, columns, selected_cells)

        gray_masked = cv2.cvtColor(masked, cv2.COLOR_BGR2GRAY)
        thresh = cv2.threshold(gray_masked, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)[1]
        
        
        # Use pytesseract to extract text from the masked image
        #masked_pil = Image.fromarray(cv2.cvtColor(masked, cv2.COLOR_BGR2RGB))
        masked_pil = Image.fromarray(thresh)
        extracted_text = pytesseract.image_to_string(masked_pil)
        
        print("Extracted Text from cells {}:".format(selected_cells))
        print(extracted_text)
        result = parse_identity(extracted_text)
        print("Result:", result)
        
        # Display the images for reference
        #cv2.imshow("Warped Card", warped)
        #cv2.imshow("Warped Card with Grid", warped_with_grid)
        cv2.imshow("Masked (Selected Cells Only)", thresh)
        cv2.waitKey(0)
        cv2.destroyAllWindows()
