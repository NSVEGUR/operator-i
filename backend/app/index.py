from flask import Flask
from app.main import bp as main
from app.intro import bp as intro
from app.arithmetic import bp as arithmetic
from app.geometric import bp as geometric
from app.spatial import bp as spatial
from app.filter import bp as filter
from app.fourier import bp as fourier


app = Flask(__name__)

app.register_blueprint(main)
app.register_blueprint(intro, url_prefix="/intro")
app.register_blueprint(arithmetic, url_prefix="/arithmetic")
app.register_blueprint(geometric, url_prefix="/geometric")
app.register_blueprint(spatial, url_prefix="/spatial")
app.register_blueprint(filter, url_prefix="/filter")
app.register_blueprint(fourier, url_prefix="/fourier")

@app.route('/test')
def test_flask():
	return 'Test route successful!'


