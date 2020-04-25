# https://dev.to/riverfount/dockerize-a-flask-app-17ag
FROM python:3.7.6-alpine

WORKDIR /app

ENV FLASK_APP server.py
ENV FLASK_RUN_HOST 0.0.0.0
ENV FLASK_RUN_PORT 4000
ENV FLASK_ENV development
ENV GOOGLE_APPLICATION_CREDENTIALS gcp_config.json

COPY requirements.txt requirements.txt
COPY server.py server.py 
COPY choose_image.py choose_image.py
COPY gcp_config.json gcp_config.json
COPY conftest.py conftest.py 
COPY tests/ tests/ 
COPY images/ images/

RUN pip install -r requirements.txt

# EXPOSE 4000

# CMD ["flask", "run"]
