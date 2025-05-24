FROM php:8.2-fpm-alpine

# Install required packages + build dependencies
RUN apk add --no-cache \
    bash \
    openssh \
    git \
    curl \
    shadow \
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
    libxml2-dev \
    libxslt-dev \
    $PHPIZE_DEPS \
    php-pear \
    ca-certificates

# Install PHP extensions (built-in)
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    zip \
    intl \
    mbstring \
    gd \
    exif \
    mysqli \
    xml \
    opcache \
    bcmath \
    calendar \
    sockets \
    xsl

# Install Redis & Xdebug via PECL
RUN pecl install redis xdebug \
    && docker-php-ext-enable redis xdebug

# Copy Composer from official image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy custom PHP configurations and Supervisor
COPY conf.d/custom.ini /usr/local/etc/php/conf.d/custom.ini
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY supervisord.conf /etc/supervisord.conf

# Set working directory
WORKDIR /var/www/html

# Default command
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
