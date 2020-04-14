from flask import Flask, request

from main import get_image_from_bucket

app = Flask(__name__)

@app.route('/')
def index():
    return get_image_from_bucket(request)
