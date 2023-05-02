from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO
import math

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def gammaTransform():
    if 'file' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400
    
    file = request.files['file']
    image = np.asarray(bytearray(file.read()), dtype="uint8")
    img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)

    gam = int(request.form['gamma'])
    c = int(request.form['c'])

    gamma = np.zeros(img.shape)
    for i in range(img.shape[0]):
        for j in range(img.shape[1]):
            gamma[i][j] = c*(math.pow(img[i][j], gam))
    
    gammaed = np.zeros(img.shape
                       )
    for i in range(img.shape[0]):
        for j in range(img.shape[1]):
            gammaed[i][j] = np.floor(255*((gamma[i][j] - np.min(gamma))/(np.max(gamma)-np.min(gamma))))
        
    

    imgenc = cv2.imencode('.png', gammaed)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")

