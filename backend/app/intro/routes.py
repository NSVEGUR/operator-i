from app.intro import bp as intro
from app.intro.binary import binaryImage
from app.intro.gray import grayImage
from app.intro.imgshape import imgShape

@intro.route("/binary", methods=["POST"])
def binary():
    return binaryImage()

@intro.route("/gray", methods=["POST"])
def gray():
    return grayImage()

@intro.route("/shape", methods=["POST"])
def shape():
    return imgShape()


