# LEMP Development Docker Environment

A LEMP (Linux, Nginx, MySQL, PHP) development environment in docker compose. It features following services:
- Web server: nginx
- DB: MySql
- PHP
- PHPMyAdmin
- Email: MailCatcher (Web UI on `http://localhost:1080`)

This environment can be used to develop a variety of PHP applications e.g.
- MVC framework app (e.g. laravel)
- WordPress themes, plugins, blocks

**Note:** Place your projects source code in `./src`.

## Example WordPress Dev Configurations

### Nginx

- Ports: 80,443
- Volumes:
    ```
    - ./nginx/conf.d/default.conf:/etc/nginx/conf.d/default.conf
    - ./src:/var/www/html:rw
    - ./nginx/log:/var/log/nginx
    ```
- host FQDN: `wordpress-dev.test`
- SSL certs: add to `./nginx/certs` using `mkcert`

### MySQL

- Environment
    ```
    MYSQL_DATABASE: wp
    MYSQL_USER: wp
    MYSQL_PASSWORD: secret
    MYSQL_ROOT_PASSWORD: secret
    ```

### PHP

- Configurations:
    ```
    www.conf: 	/usr/local/etc/php-fpm.d/www.conf
    php.ini:  	/usr/local/etc/php/php.ini
    ssmtp.conf: /etc/ssmtp/ssmtp.conf
    ```
- Volumes:
    - `./src:/var/www/html:rw`

### MailCatcher

- SMTP Port: 1025
- Web UI Port: 1080
- Environment
    ```
    PMA_HOST: mysql
    MYSQL_USER: wp
    MYSQL_PASSWORD: secret
    MYSQL_ROOT_PASSWORD: secret
    ```

