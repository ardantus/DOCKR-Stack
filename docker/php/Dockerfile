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
    git \
    libxml2-dev \
    libxslt-dev

# Install PHP extensions
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    zip \
    intl \
    mbstring \
    gd \
    bcmath \
    calendar \
    sockets \
    xsl

# Install Xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Install Composer by copying from official Composer image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy custom configurations
COPY conf.d/custom.ini /usr/local/etc/php/conf.d/custom.ini
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY supervisord.conf /etc/supervisord.conf

# Set working directory
WORKDIR /var/www/html

# Start supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
