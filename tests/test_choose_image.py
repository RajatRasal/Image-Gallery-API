import random

import pytest

seed = 42
random.seed(seed)


def test_get_random_image_endpoint(client):
    response = client.get()
    assert False
