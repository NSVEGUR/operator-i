from app.main import bp as main

@main.route('/')
def index():
    return "Main route..."


@main.route('/hey/')
def hey():
    return "Hey from Main ..."