from app.fourier import bp as fourier

from app.fourier.fourierTrans import fourierTrans
@fourier.route("/fourier", methods=["POST"])
def fourierTransorm():
    return fourierTrans()

