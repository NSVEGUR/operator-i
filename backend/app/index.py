from flask import Flask
from app.main import bp as main
from app.intro import bp as intro


app = Flask(__name__)

app.register_blueprint(main)
app.register_blueprint(intro, url_prefix="/intro")

@app.route('/test')
def test_flask():
	return 'Test route successful!'

