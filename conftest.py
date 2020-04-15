import pytest

from server import APP


@pytest.fixture
def client():
    return APP.test_client()
