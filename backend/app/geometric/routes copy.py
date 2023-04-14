from app.geometric import bp as spatial

from app.geometric.scaling import scaleImage
@spatial.route("/scaling", methods=["POST"])
def scaling():
    return scaleImage()

from app.geometric.rotate import rotateImage
@spatial.route("/rotate", methods=["POST"])
def rotation():
    return rotateImage()

from app.geometric.translation import translateImage
@spatial.route("/translate", methods=["POST"])
def translation():
    return translateImage()

from app.geometric.shear import shearImage
@spatial.route("/shear", methods=["POST"])
def shear():
    return shearImage()

from app.geometric.reflection import reflectImage
@spatial.route("/reflect", methods=["POST"])
def reflect():
    return reflectImage()

