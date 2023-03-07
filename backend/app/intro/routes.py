from app.intro import bp as intro
from flask import request, send_file
from app.utils.img import encode, decode

@intro.route('/')
def index():
    return "Intro route..."

@intro.route('/hey/')
def hey():
    return "Hey from Intro ..."

@intro.route('/grayscale', methods=['POST'])
def grayscale():
    file = request.files['file']
    buffer = file.read()
    decoded = decode(buffer)
    encoded = encode(decoded, f".{file.filename.split('.').pop()}")
    return send_file(encoded, attachment_filename=file.filename, as_attachment=True)