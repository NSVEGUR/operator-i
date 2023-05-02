from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def sobel():
    if 'file' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400
    file = request.files['file']
    image = np.asarray(bytearray(file.read()), dtype="uint8")
    img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)
    axis = request.form['axis']
    kersize = int(request.form['kernelsize'])

    if kersize%2 == 0:
        return("ENTER ODD KERNEL SIZE!")
    if axis!= 'x' and axis!= 'X' and axis!= 'y' and axis!= 'Y':
        return ("MENTION CORRECT AXIS: X/x or Y/y")
    
    if axis == 'x' or axis == 'X':
        filtered = cv2.Sobel(img, cv2.CV_8U, 1,0, ksize=kersize)
    else:
        filtered = cv2.Sobel(img, cv2.CV_8U, 0,1, ksize=3)
    
    imgenc = cv2.imencode('.png', filtered)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")

