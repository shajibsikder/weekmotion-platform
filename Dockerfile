# ==============================================================================
# Weekmotion Platform Container Architecture
# Optimized Multi-Service Media Ingestion & Web Gateway Environment
# Base: Alpine Linux 3.21 with PHP 8.3-FPM, Node.js 22 LTS, FFmpeg & Nginx
# ==============================================================================

FROM php:8.3-fpm-alpine3.21 AS base

WORKDIR /var/www/html

# Import Pinned Node.js 22 LTS and npm from official Node image
COPY --from=node:22-alpine /usr/local/bin/node /usr/local/bin/node
COPY --from=node:22-alpine /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

# Install Production System Toolchain, Nginx, Supervisor, FFmpeg, Node Runtime Libs
RUN apk add --no-cache \
    nginx \
    supervisor \
    ffmpeg \
    libstdc++ \
    curl \
    git \
    unzip \
    libpng \
    libjpeg-turbo \
    freetype \
    libzip \
    icu-libs \
    oniguruma

# Build PHP Extensions with Build Dependencies, then Purge Build Tools
RUN apk add --no-cache --virtual .build-deps \
        libpng-dev \
        libjpeg-turbo-dev \
        freetype-dev \
        libzip-dev \
        icu-dev \
        oniguruma-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        mysqli \
        pdo_mysql \
        bcmath \
        gd \
        zip \
        intl \
        mbstring \
        opcache \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* /tmp/*

# Deploy Enterprise Configurations
COPY ./docker/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/supervisor.conf /etc/supervisor/conf.d/supervisor.conf
COPY ./docker/php.ini /usr/local/etc/php/conf.d/99-weekmotion.ini
COPY ./docker/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Setup application directory structure and secure permissions
RUN mkdir -p /var/www/html/upload/photos \
             /var/www/html/upload/videos \
             /var/www/html/cache \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/upload /var/www/html/cache

# Copy codebase with non-root ownership
COPY --chown=www-data:www-data . .

# Expose HTTP port (80) & Real-time WebSockets port (8000)
EXPOSE 80 8000

# Container Healthcheck (Nginx gateway + WebSocket broker)
HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
    CMD curl -f http://localhost/ && curl -f http://localhost:8000/health || exit 1

# Start Supervisor Process Manager
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisor.conf"]
