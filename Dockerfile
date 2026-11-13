# ==============================================================================
# Weekmotion Platform Container Architecture
# Optimized Multi-Service Media Ingestion & Web Gateway Environment
# Base: Alpine Linux with PHP 8.2/8.3, Node.js 20 LTS, FFmpeg & Nginx
# ==============================================================================

FROM php:8.2-fpm-alpine

WORKDIR /var/www/html

# System toolchain & multimedia dependencies
RUN apk add --no-cache \
    nginx \
    supervisor \
    ffmpeg \
    nodejs \
    npm \
    git \
    curl \
    unzip \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    icu-dev \
    oniguruma-dev

# Compile PHP core extensions for video processing & database transaction safety
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        mysqli \
        pdo_mysql \
        bcmath \
        gd \
        zip \
        intl \
        mbstring \
        opcache

# Deploy optimized service configurations
COPY ./docker/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/supervisor.conf /etc/supervisor/conf.d/supervisor.conf

# Setup runtime storage, buffer directories, and file permissions
RUN mkdir -p /var/www/html/upload/photos \
             /var/www/html/upload/videos \
             /var/www/html/cache \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/upload /var/www/html/cache

# Copy application blueprints & assets
COPY . .

# Expose HTTP port (80) & Real-time WebSockets port (8000)
EXPOSE 80 8000

# Start Supervisor process manager orchestrating Nginx and PHP-FPM
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisor.conf"]
