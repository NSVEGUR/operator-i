from flask import request, send_file
import numpy as np
import cv2
from io import BytesIO

ALLOWED_EXTENSIONS = set(['png', 'jpg','jpeg'])

def allowed(filename):
    return '.' in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

def reflectImage():
    if 'file' not in request.files:
        return ("ERROR: MEDIA NOT UPLOADED"), 400

    file = request.files['file']
    image = np.asarray(bytearray(file.read()), dtype="uint8")
    img = cv2.imdecode(image, cv2.IMREAD_GRAYSCALE)
    h, w = img.shape
    M = np.float32([[1,  0, 0],[0, -1, h],[0,  0, 1]])
    reflected = cv2.warpPerspective(img, M,
                                   (int(w),
                                    int(h)))
    sheared = cv2.warpPerspective(img, M, (int(w*1.5), int(h*1.5)))
    imgenc = cv2.imencode('.png', reflected)[1]
    return send_file(BytesIO(imgenc), mimetype="image/gif")

