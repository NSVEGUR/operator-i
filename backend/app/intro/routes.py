from app.intro import bp as intro

@intro.route('/')
def index():
    return "Intro route..."

@intro.route('/hey/')
def hey():
    return "Hey from Intro ..."