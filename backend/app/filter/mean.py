from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def meanFilter():
    if 'file' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400
    file = request.files['file']
    image = np.asarray(bytearray(file.read()), dtype="uint8")
    img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)

    mean = (1/9)*np.array([[1,1,1], [1,1,1], [1,1,1]])
    filtered = cv2.filter2D(img, -1, mean)
    
    imgenc = cv2.imencode('.png', filtered)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")

