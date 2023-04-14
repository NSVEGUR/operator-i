from app.geometric import bp as geometric

from app.geometric.scaling import scaleImage
@geometric.route("/scaling", methods=["POST"])
def scaling():
    return scaleImage()

from app.geometric.rotate import rotateImage
@geometric.route("/rotate", methods=["POST"])
def rotation():
    return rotateImage()

from app.geometric.translation import translateImage
@geometric.route("/translate", methods=["POST"])
def translation():
    return translateImage()

from app.geometric.shear import shearImage
@geometric.route("/shear", methods=["POST"])
def shear():
    return shearImage()

from app.geometric.reflection import reflectImage
@geometric.route("/reflect", methods=["POST"])
def reflect():
    return reflectImage()

