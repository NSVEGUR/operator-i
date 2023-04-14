from app.intro import bp as intro
from flask import request, send_file
import numpy as np
import cv2

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def imgShape():
    if 'file' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400

    file = request.files['file']
    image = np.asarray(bytearray(file.read()), dtype="uint8")
    img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)
    r,c = img.shape
    l = [r,c]
    print(l)
    return l