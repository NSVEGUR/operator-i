import scipy
from app.intro import bp as intro
from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def medianFilter():
    if 'file' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400
    file = request.files['file']
    image = np.asarray(bytearray(file.read()), dtype="uint8")
    img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)

    a = int(request.form['a'])
    b = int(request.form['b'])

    if a%2 == 0 and b%2 == 0:
        return ("PLEASE ENTER ODD WINDOW SIZE EXCEPT '1'")
    def median(img, a, b):
        padded = cv2.copyMakeBorder(img, 2*a,2*a,2*b,2*b, cv2.BORDER_CONSTANT, 0)
        r, c = padded.shape
        new = np.zeros((r-(2*a), c-(2*b)))
        kernel = np.full((2*a+1, 2*b+1), 1)
        for i in range(r-(2*a)):
            for j in range(c-(2*b)):
                d = np.multiply(kernel, padded[i:i+(2*a)+1,j:j+(2*b)+1])
                new[i,j] = np.median(d)
        return new
    median = median(img, (a-1)//2, (b-1)//2)
    imgenc = cv2.imencode('.png', median)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")

