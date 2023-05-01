from flask import Blueprint

bp = Blueprint('fourier', __name__)


from app.fourier import routes