from flask import Blueprint

bp = Blueprint('filter', __name__)


from app.filter import routes



