from app.spatial import bp as spatial


from app.spatial.histmatching import histogramMatching
@spatial.route("/match", methods=["POST"])
def match():
    return histogramMatching()

from app.spatial.histequalisation import histogramEqualisation
@spatial.route("/equalize", methods=["POST"])
def equalize():
    return histogramEqualisation()