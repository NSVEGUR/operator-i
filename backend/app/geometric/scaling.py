from app.intro import bp as intro
from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def scaleImage():
    if 'file' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400

    file = request.files['file']
    scale1 = int(request.form['scale1'])
    scale2 = int(request.form['scale2'])
    image = np.asarray(bytearray(file.read()), dtype="uint8")
    if scale1 and scale2 <= 0:
        return ("PLEASE ENTER POSITIVE SCALING"), 400
    img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)
    scaled = cv2.resize(img, (scale1*img.shape[0], scale2*img.shape[1]))
    imgenc = cv2.imencode('.png', scaled)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")

