from app.spatial import bp as spatial


from app.spatial.histmatching import histogramMatching
@spatial.route("/match", methods=["POST"])
def match():
    return histogramMatching()

from app.spatial.histequalisation import histogramEqualisation
@spatial.route("/equalize", methods=["POST"])
def equalize():
    return histogramEqualisation()

from app.spatial.logtransform import logTransform
@spatial.route("/logtrans", methods=["POST"])
def log():
    return logTransform()

from app.spatial.gammatransform import gammaTransform
@spatial.route("/gamma", methods=["POST"])
def gamma():
    return gammaTransform()

from app.spatial.constrastenhance import contEnhance
@spatial.route("/enhance", methods=["POST"])
def enhance():
    return contEnhance()