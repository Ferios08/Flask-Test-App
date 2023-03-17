FROM python:3.10-alpine3.15

WORKDIR /flask-sample-app

COPY . ./

RUN apk add --no-cache --virtual .build-deps \
        gcc \
        libc-dev \
        libffi-dev \
        openssl-dev \
        make \
    && pip install --no-cache-dir poetry==1.1.13 \
    && poetry export > requirements.txt \
    && pip3 install --no-cache-dir  -r requirements.txt

ENTRYPOINT [ "flask" ]

CMD ["run", "--host", "0.0.0.0", "--port", "8080"]
