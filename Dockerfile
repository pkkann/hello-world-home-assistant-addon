FROM ghcr.io/home-assistant/base:latest

# Install Nginx, PHP-FPM, Supervisor, and required Symfony extensions
RUN apk add --no-cache \
    nginx \
    supervisor \
    php83 \
    php83-fpm \
    php83-ctype \
    php83-curl \
    php83-dom \
    php83-fileinfo \
    php83-iconv \
    php83-intl \
    php83-json \
    php83-mbstring \
    php83-opcache \
    php83-openssl \
    php83-pdo \
    php83-pdo_mysql \
    php83-phar \
    php83-session \
    php83-simplexml \
    php83-tokenizer \
    php83-xml \
    php83-xmlwriter \
    composer

# Configure Nginx to point to Symfony's public directory
RUN mkdir -p /run/nginx /run/php /var/www/html
COPY nginx.conf /etc/nginx/http.d/default.conf

COPY ./app /var/www/html
WORKDIR /var/www/html

# Copy Supervisor configuration
COPY supervisord.conf /etc/supervisord.conf

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
