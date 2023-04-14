from app.intro import bp as intro
from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def translateImage():
    if 'file' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400

    file = request.files['file']
    x = int(request.form['y'])
    y = int(request.form['x'])
    image = np.asarray(bytearray(file.read()), dtype="uint8")
    img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)
    h, w = img.shape
    T = np.float32([[1, 0, y], [0, 1, x]])
    translated = cv2.warpAffine(img, T, (w, h))
    imgenc = cv2.imencode('.png', translated)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")

