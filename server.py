import os

from flask import Flask, request

from main import choose_image

app = Flask(__name__)


@app.route('/')
def index():
    return choose_image(request)
