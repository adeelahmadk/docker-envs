FROM nginx:stable-alpine

ADD ./nginx/nginx.conf /etc/nginx/nginx.conf
ADD ./nginx/default.conf /etc/nginx/conf.d/default.conf
ADD ./nginx/certs /etc/nginx/certs/self-signed

RUN addgroup -g 1000 lemp && \
    adduser -u 1000 \
            -G lemp \
            -g "lemp dev" \
            -s /bin/sh \
            -D lemp && \
    mkdir -p /var/www/html && \
    chown lemp:lemp /var/www/html
