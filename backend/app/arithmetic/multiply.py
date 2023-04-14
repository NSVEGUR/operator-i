from app.intro import bp as intro
from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def multiplyImages():
    if 'file' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400
    files = request.files.getlist('file')
    images = []
    for i in range(len(files)):
            image = np.asarray(bytearray(files[i].read()), dtype="uint8")
            img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)
            images.append(img)
    if images[0].shape != images[1].shape:
        return ("CORRECT IMAGES UPLOAD MAD LE MARAYA!!"), 400

    mul = np.multiply(images[0], images[1])
    for i in range(mul.shape[0]):
        for j in range(mul.shape[1]):
            img[i][j] = np.floor(255*((mul[i][j] - np.min(mul))/(np.max(mul)-np.min(mul))))

    imgenc = cv2.imencode('.png', img)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")
        
