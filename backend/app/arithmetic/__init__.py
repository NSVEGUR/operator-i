from flask import Blueprint

bp = Blueprint('arithmetic', __name__)


from app.arithmetic import routes



