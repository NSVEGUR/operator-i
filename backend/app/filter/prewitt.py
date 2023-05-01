import scipy
from app.intro import bp as intro
from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def prewitt():
    if 'file' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400
    file = request.files['file']
    image = np.asarray(bytearray(file.read()), dtype="uint8")
    img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)
    axis = request.form['axis']

    if axis!= 'x' and axis!= 'X' and axis!= 'y' and axis!= 'Y':
        return ("MENTION CORRECT AXIS: X/x or Y/y")
    
    prewitt_x = np.array([[1,0,-1], [1,0,-1], [1,0,-1]])
    prewitt_y = np.array([[1,1,1], [0,0,0], [-1,-1,-1]])
    if axis == 'x' or axis == 'X':
        filtered = cv2.filter2D(img, -1, prewitt_x)
    else:
        filtered = cv2.filter2D(img, -1, prewitt_y)
    
    imgenc = cv2.imencode('.png', filtered)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")

