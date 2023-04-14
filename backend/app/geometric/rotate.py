from app.intro import bp as intro
from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def rotateImage():
    if 'file' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400

    file = request.files['file']
    angle = int(request.form['angle'])
    point = int(request.form['point'])
    image = np.asarray(bytearray(file.read()), dtype="uint8")
    img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)

    if point!=0 and point!=1 and point!=2 and point!=3:
        return ("CORRECT CENTER KODO MARAYA")
    elif point == 0:
        center = (0,0)
    elif point == 1:
        center = (0, img.shape[1])
    elif point == 2:
        center = (img.shape[0], 0)
    elif point == 3:
        center = (img.shape[0], img.shape[1])
    rotMat = cv2.getRotationMatrix2D(center=center, angle=angle, scale=1) 
    rotated = cv2.warpAffine(
    src=img, M=rotMat, dsize=(1*img.shape[0], 4*img.shape[1]))
    imgenc = cv2.imencode('.png', rotated)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")

