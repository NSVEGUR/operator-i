from app.intro import bp as intro
from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def divideImages():
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

    div = np.divide(images[0], images[1])
    for i in range(div.shape[0]):
        for j in range(div.shape[1]):
            img[i][j] = np.floor(255*((div[i][j] - np.min(div))/(np.max(div)-np.min(div))))

    imgenc = cv2.imencode('.png', img)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")
        
