from app.arithmetic.add import addImages
from app.arithmetic.subtract import subImages
from app.arithmetic.multiply import multiplyImages
from app.arithmetic.divide import divideImages

@arithmetic.route("/add", methods=["POST"])
def add():
    return addImages()

@arithmetic.route("/subtract", methods=["POST"])
def sub():
    return subImages()

@arithmetic.route("/multiply", methods=["POST"])
def multiply():
    return multiplyImages()

@arithmetic.route("/divide", methods=["POST"])
def divide():
    return divideImages()