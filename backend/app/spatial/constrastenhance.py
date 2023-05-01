from app.intro import bp as intro
from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def contEnhance():
    if 'file' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400
    
    file = request.files['file']
    image = np.asarray(bytearray(file.read()), dtype="uint8")
    img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)
    # coeff = request.form['coeff']
    
    for i in range(img.shape[0]):
        for j in range(img.shape[1]):
            if img[i][j] >= 50 and img[i][j]<=100:
                img[i][j] = 10 * img[i][j]

    imgenc = cv2.imencode('.png', img)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")

