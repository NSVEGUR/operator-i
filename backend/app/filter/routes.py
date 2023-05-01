from app.filter import bp as filter

from app.filter.mean import meanFilter
@filter.route("/mean", methods=["POST"])
def mean():
    return meanFilter()

from app.filter.gaussian import gaussianFilter
@filter.route("/gaussian", methods=["POST"])
def gaussian():
    return gaussianFilter()

from app.filter.median import medianFilter
@filter.route("/median", methods=["POST"])
def medianFilt():
    return medianFilter()

from app.filter.prewitt import prewitt
@filter.route("/prewitt", methods=["POST"])
def prewittFilt():
    return prewitt()

from app.filter.sobel import sobel
@filter.route("/sobel", methods=["POST"])
def sobelFilt():
    return sobel()

from app.filter.canny import canny
@filter.route("/canny", methods=["POST"])
def cannyFilt():
    return canny()

from app.filter.laplacian import laplacian
@filter.route("/laplacian", methods=["POST"])
def laplacianFilt():
    return laplacian()