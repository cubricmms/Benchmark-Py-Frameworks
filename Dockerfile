ARG VERSION=3.9-alpine
##############################
### BASE Image
##############################
FROM python:${VERSION} as base

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 imagemagick dependencies
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add imagemagick \
            gcc \
            python3-dev \
            libc-dev \
            libffi-dev \
    && rm -rf /var/cache/apk/*

##############################
### BUILDER Image
##############################
FROM base as builder

# install dependencies
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
ENV PIP_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple

COPY ./requirements.txt .
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

##############################
### Django Image
##############################
FROM base as web_django

ENV PATH="/opt/venv/bin:$PATH"

COPY --from=builder /opt/venv /opt/venv

WORKDIR /usr/src/app

# copy project
COPY ./django-on-docker .

##############################
### Fast API Image
##############################
FROM base as web_fastapi

ENV PATH="/opt/venv/bin:$PATH"

COPY --from=builder /opt/venv /opt/venv

WORKDIR /usr/src/app

COPY ./fastapi-on-docker .
