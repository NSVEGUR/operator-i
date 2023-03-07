import cv2
import numpy as np
from io import BytesIO


def decode(buffer):
    buffer_array = bytearray(buffer)
    arr = np.asarray(buffer_array, dtype="uint8")
    # img = cv2.imdecode(arr, cv2.IMREAD_COLOR)
    img =  cv2.imdecode(arr, cv2.IMREAD_GRAYSCALE)
    return img

def encode(img, file_type):
    img = cv2.imencode(file_type, img)[1]
    img = np.array(img)
    img_bytes = BytesIO(img.tobytes())
    return img_bytes

