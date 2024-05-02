import easyocr as ocr
import streamlit as st
from PIL import Image, ImageDraw
import numpy as np
import cv2
import ssl

ssl._create_default_https_context = ssl._create_unverified_context

def rotate_image(image, angle):
    """
    Rotate the given image by the specified angle.

    Args:
    image (PIL.Image): Input image.
    angle (float): Angle in degrees to rotate the image.

    Returns:
    PIL.Image: Rotated image.
    """
    return image.rotate(angle, expand=True)

def find_corners(image):
    """
    Find the corners of an A4 paper in the given image.

    Args:
    image (PIL.Image): Input image.

    Returns:
    List[Tuple[int, int]]: List of corner coordinates.
    """
    # Define A4 paper dimensions (in millimeters)
    a4_width_mm = 210
    a4_height_mm = 297

    # Convert A4 dimensions to pixels (assuming 300 DPI)
    a4_width_px = int(a4_width_mm / 25.4 * 300)
    a4_height_px = int(a4_height_mm / 25.4 * 300)

    # Resize image to reduce computation time
    resized_image = image.resize((a4_width_px, a4_height_px))

    # Convert image to grayscale
    gray = cv2.cvtColor(np.array(resized_image), cv2.COLOR_RGB2GRAY)
    
    # Apply Gaussian blur to reduce noise
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    
    # Use Canny edge detection to find edges
    edges = cv2.Canny(blurred, 50, 150)
    
    # Find contours in the edged image
    contours, _ = cv2.findContours(edges.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    
    # Sort the contours by area and find the largest contour
    contour = max(contours, key=cv2.contourArea)
    
    # Compute the bounding box of the contour
    rect = cv2.minAreaRect(contour)
    box = cv2.boxPoints(rect)
    box = np.int0(box)
    
    # Convert box points back to original image size
    box[:, 0] = box[:, 0] * (resized_image.width / a4_width_px)
    box[:, 1] = box[:, 1] * (resized_image.height / a4_height_px)
    
    return box

def perspective_correction(image):
    """
    Perform perspective correction on the given image using A4 paper corners.

    Args:
    image (PIL.Image): Input image.

    Returns:
    PIL.Image: Perspective corrected image.
    """
    # Find corners of A4 paper
    corners = find_corners(image)
    
    # Calculate the perspective transform matrix and warp the image
    width = max(np.linalg.norm(corners[0] - corners[1]), np.linalg.norm(corners[1] - corners[2]))
    height = max(np.linalg.norm(corners[1] - corners[2]), np.linalg.norm(corners[2] - corners[3]))
    dst = np.array([[0, 0], [width - 1, 0], [width - 1, height - 1], [0, height - 1]], dtype="float32")
    M = cv2.getPerspectiveTransform(np.array(corners, dtype="float32"), dst)
    warped = cv2.warpPerspective(np.array(image), M, (int(width), int(height)))
    
    return Image.fromarray(warped)

st.title("OCR Project for Team Software Engineering")
image = st.file_uploader(label="Upload an image!", type=['png', 'jpg', 'jpeg'])

rotate_angle = st.sidebar.slider("Rotate Image", -180, 180, 0, 1)

if image is not None:
    input_image = Image.open(image)  # reading image
    rotated_image = rotate_image(input_image, rotate_angle)
    
    st.image(rotated_image)  # displaying image
    
    if st.button("Process Image"):
        with st.spinner("Working to process your image!"):
            reader = ocr.Reader(['en'], model_storage_directory='.')
            result = reader.readtext(np.array(rotated_image))

            result_text = []

            for text in result:
                result_text.append(text[1])

            st.write(result_text)

        st.success("This is the result!")

    if st.button("Process Image with Perspective Correction"):
        with st.spinner("Working to process your image with perspective correction!"):
            corrected_image = perspective_correction(rotated_image)
            st.image(corrected_image, caption="Perspective Corrected Image")
            
            reader = ocr.Reader(['en'], model_storage_directory='.')
            result = reader.readtext(np.array(corrected_image))

            result_text = []

            for text in result:
                result_text.append(text[1])

            st.write(result_text)

        st.success("This is the result!")
else:
    st.write("Upload your image")
