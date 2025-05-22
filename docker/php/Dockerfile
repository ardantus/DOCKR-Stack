FROM php:8.2-fpm-alpine

# Install required Alpine packages
RUN apk add --no-cache \
    bash \
    shadow \
    curl \
    supervisor \
    linux-headers \
    gcc \
    g++ \
    make \
    autoconf \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    icu-dev \
    oniguruma-dev \
    openssl \
    git

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql zip intl mbstring gd

# Install Xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Copy custom php.ini configuration
COPY conf.d/custom.ini /usr/local/etc/php/conf.d/custom.ini
# Copy Xdebug config and supervisor config
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
