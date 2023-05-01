import scipy
from app.intro import bp as intro
from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def laplacian():
    if 'file' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400
    file = request.files['file']
    image = np.asarray(bytearray(file.read()), dtype="uint8")
    img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)
    sign = request.form['sign']
    if sign!= 'p' and sign!='P' and sign!='N' and sign!= 'n':
        return("ENTER CORRECT SIGN: P/p or N/n")

    laplacian = np.array([[0,1,0], [1,-4,1],[0,-1,0]])

    if sign == 'p' or sign == 'P':
        filtered = cv2.filter2D(img, -1, laplacian)
    else:
        filtered = cv2.filter2D(img, -1, -1*laplacian)
    
    imgenc = cv2.imencode('.png', filtered)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")

