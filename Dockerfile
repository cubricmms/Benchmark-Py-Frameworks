ARG VERSION=3.9-alpine
##############################
### BASE Image
##############################
FROM python:${VERSION} as base

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 imagemagick dependencies
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev file imagemagick \
    && rm -rf /var/cache/apk/*

##############################
### BUILDER Image
##############################
FROM base as builder

# install dependencies
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --no-cache-dir -r requirements.txt

##############################
### Django Image
##############################
FROM base as web_django

ENV PATH="/opt/venv/bin:$PATH"

COPY --from=builder /opt/venv /opt/venv

WORKDIR /usr/src/app

# copy project
COPY ./django-on-docker .
