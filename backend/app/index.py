from flask import Flask
from main import bp as main
from intro import bp as intro
from arithmetic import bp as arithmetic
from geometric import bp as geometric
from spatial import bp as spatial



app = Flask(__name__)

app.register_blueprint(main)
app.register_blueprint(intro, url_prefix="/intro")
app.register_blueprint(arithmetic, url_prefix="/arithmetic")
app.register_blueprint(geometric, url_prefix="/geometric")
app.register_blueprint(spatial, url_prefix="/spatial")

@app.route('/test')
def test_flask():
	return 'Test route successful!'


