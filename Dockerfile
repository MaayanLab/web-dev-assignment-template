# Python setup from https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/blob/master/Dockerfile
FROM alpine:3.10

# This hack is widely applied to avoid python printing issues in docker containers.
# See: https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/pull/13
ENV PYTHONUNBUFFERED=1

RUN echo "**** install Python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi
    
RUN apk add --update \
    sqlite

WORKDIR /app
# copy application
ADD . /app

RUN pip install -r ontology_app/requirements.txt

ENV FLASK_APP=ontology_app
ENV FLASK_ENV=production

EXPOSE 5000

RUN python initialize_db.py
RUN python fill_db.py

CMD flask run --host=0.0.0.0