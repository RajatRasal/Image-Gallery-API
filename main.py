import os
import random

from flask import jsonify, abort
from google.cloud import storage

ALLOW_FROM = 'https://rajatrasal.github.io'
STORAGE_CLIENT = storage.Client()


def choose_image(request):
    if request.method == 'GET':
        bucket = 'blog-image-gallery'
        images = list(STORAGE_CLIENT.list_blobs(bucket))
        image = random.choice(images)
        image_url = f'https://storage.cloud.google.com/{bucket}/{image.name}'
        metadata = image.metadata

        response = jsonify(image_url=image_url,
                           desc=metadata['Image-Description'],
                           date=metadata['Image-Date'])
        response.headers.set('Access-Control-Allow-Origin', ALLOW_FROM)
        response.headers.set('Access-Control-Allow-Methods', 'GET, POST')
        return response
    else:
        return abort(403)
