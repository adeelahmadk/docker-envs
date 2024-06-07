FROM php:fpm-alpine

# copy the Composer PHAR from the Composer image into the PHP image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# add php & smtp configurations
ADD ./php/www.conf /usr/local/etc/php-fpm.d/www.conf
ADD ./php/php.ini /usr/local/etc/php/php.ini
ADD ./php/ssmtp.conf /etc/ssmtp/ssmtp.conf

# add non-root group & user (1000:1000) and
# assign ownership of the default directory.
RUN addgroup -g 1000 lemp && \
    adduser -u 1000 \
            -G lemp \
            -g "lemp dev" \
            -s /bin/sh \
            -D lemp && \
    mkdir -p /var/www/html && \
    chown lemp:lemp /var/www/html

# install php extensions for wordpress
RUN apk add --update --no-cache icu-dev libzip-dev zip ssmtp
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS imagemagick-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del .build-deps
RUN docker-php-ext-install mysqli exif intl zip && \
    rm -rf /tmp/* /var/cache/apk/*

WORKDIR /var/www/html
