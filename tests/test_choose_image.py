import pytest


def test_get_random_image_endpoint(client):
    response = client.get()
    print(response.json)
    assert False
