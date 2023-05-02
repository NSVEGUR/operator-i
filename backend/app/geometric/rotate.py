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
    image = np.asarray(bytearray(file.read()), dtype="uint8")
    img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)

    x = img.shape[0]//2
    y = img.shape[1]//2

    center = (x,y)

    aspect_ratio = img.shape[0] / img.shape[1]
    output_width = 960
    output_height = int(output_width / aspect_ratio)
    rotMat = cv2.getRotationMatrix2D(center=center, angle=angle, scale=1) 
    rotated = cv2.warpAffine(
    src=img, M=rotMat, dsize=(output_width,output_height))
    imgenc = cv2.imencode('.png', rotated)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")

