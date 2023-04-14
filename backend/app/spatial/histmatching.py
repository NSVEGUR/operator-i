from app.intro import bp as intro
from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def histogramMatching():
    if 'file1' and 'file2' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400
    
    file1 = request.files['file1']
    image1 = np.asarray(bytearray(file1.read()), dtype="uint8")
    img1 = cv2.imdecode(image1, cv2.IMREAD_GRAYSCALE)

    file2 = request.files['file2']
    image2 = np.asarray(bytearray(file2.read()), dtype="uint8")
    img2 = cv2.imdecode(image2, cv2.IMREAD_GRAYSCALE)
    
    match = cv2.equalizeHist(img1, img2)

    imgenc = cv2.imencode('.png', match)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")

