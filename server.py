import os
import random

from flask import Flask, request

from choose_image import choose_image

seed = 42
random.seed(seed)

app = Flask(__name__)


@app.route('/')
def index():
    return choose_image(request)
