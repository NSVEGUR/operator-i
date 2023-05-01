from app.intro import bp as intro
from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def logTransform():
    if 'file' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400
    
    file = request.files['file']
    image = np.asarray(bytearray(file.read()), dtype="uint8")
    img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)
    

    c = 255 / np.log(1 + np.max(img))
    log_image = c * (np.log(img + 1))
    log_image = np.array(log_image, dtype = np.uint8)
    imgenc = cv2.imencode('.png', log_image)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")

