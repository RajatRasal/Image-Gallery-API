import os
import random

from flask import jsonify
from google.cloud import storage


allow_from = 'https://rajatrasal.github.io'
storage_client = storage.Client()

try:
    # For local run
    current_dir = os.path.dirname(os.path.abspath(__file__))
    gcp_config = os.path.join(current_dir, 'blog_buckets_config.json')
    os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = gcp_config
except:
    # Config file not needed when deployed on GCP
    pass


def choose_image(request):
    if request.method == 'GET':
        bucket = 'blog-image-gallery'
        image = random.choice(list(storage_client.list_blobs(bucket)))
        image_url = f'https://storage.cloud.google.com/{bucket}/{image.name}'
        metadata = image.metadata

        response = jsonify(image_url=image_url,
                           desc=metadata['Image-Description'],
                           date=metadata['Image-Date'])
        response.headers.set('Access-Control-Allow-Origin', allow_from)
        response.headers.set('Access-Control-Allow-Methods', 'GET, POST')
        return response
    else:
        return abort(403)


if __name__ == '__main__':
    print(get_image_from_bucket(None))
