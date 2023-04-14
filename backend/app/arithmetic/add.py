from app.intro import bp as intro
from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def addImages():
    if 'file' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400
    files = request.files.getlist('file')
    images = []
    for i in range(len(files)):
            image = np.asarray(bytearray(files[i].read()), dtype="uint8")
            img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)
            images.append(img)
    if images[0].shape == images[1].shape:
        added = sum(images)
        img = np.copy(added)

        for i in range(added.shape[0]):
             for j in range(added.shape[1]):
                  img[i][j] = np.floor(255*((added[i][j] - np.min(added))/(np.max(added)-np.min(added))))
        
        imgenc = cv2.imencode('.png', img)[1]
        return send_file(BytesIO(imgenc), mimetype="image/gif")
    else:
         return ("CORRECT IMAGES UPLOAD MAD LE MARAYA!!")
