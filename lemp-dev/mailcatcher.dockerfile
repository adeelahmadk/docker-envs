FROM ruby:2.7-alpine

LABEL maintainer="Johannes Schickling <schickling.j@gmail.com>"

ARG VERSION
ENV BUILD_VERSION=${VERSION:-0.8.2}

RUN set -xe \
    && apk add --no-cache \
        libstdc++ \
        sqlite-libs \
    && apk add --no-cache --virtual .build-deps \
        build-base \
        sqlite-dev \
    && gem install mailcatcher -v ${BUILD_VERSION} --no-document \
    && apk del .build-deps

ENV HTTPPATH="/"

# smtp port & webserver port
EXPOSE 1025 1080

ENTRYPOINT ["sh", "-c", "mailcatcher --no-quit --foreground --ip=0.0.0.0 --http-path ${HTTPPATH}"]
