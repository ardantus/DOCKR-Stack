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
RUN apk add --no-cache \
    imagemagick-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libwebp-dev \
    libxpm-dev \
    tidyhtml-dev \
    gmp-dev \
    sqlite-dev \
    postgresql-dev \
    libevent-dev \
    gettext-dev

RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pdo_sqlite \
    zip \
    intl \
    mbstring \
    gd \
    bz2 \
    exif \
    mysqli \
    xml \
    opcache \
    bcmath \
    calendar \
    sockets \
    xsl \
    soap \
    pcntl \
    sysvmsg \
    sysvsem \
    sysvshm \
    shmop \
    posix \
    gmp \
    tidy \
    ftp \
    gettext

# Optional: Install mcrypt and memcached via PECL
RUN pecl install mcrypt memcached \
    && docker-php-ext-enable mcrypt memcached

# Install Redis & Xdebug via PECL
RUN pecl install redis xdebug \
    && docker-php-ext-enable redis xdebug

# Install Imagick via PECL
RUN apk add --no-cache imagemagick-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick

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
