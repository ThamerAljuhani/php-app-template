# ─── STAGE 1: DEPENDENCIES ────────────────────────────────────────────────────
FROM composer:2.8 AS deps

WORKDIR /app

# Copy only composer files to leverage cache
COPY composer.json composer.lock ./

# Install PHP dependencies (no-dev)
RUN composer install \
    --no-dev \
    --optimize-autoloader \
    --no-interaction \
    --no-progress

# ─── STAGE 2: FINAL IMAGE ─────────────────────────────────────────────────────
FROM php:8.4-apache

# ─── Install system and PHP build dependencies, PECL extensions, and PHP modules ──
RUN set -eux; \
    # Install system libraries required for PHP extensions and tools
    apt-get update && apt-get install -y --no-install-recommends \
      libicu-dev \
      libxml2-dev \
      zlib1g-dev \
      libpng-dev libjpeg-dev libfreetype6-dev \
      libmagickwand-dev pkg-config \
      libonig-dev \
      unzip \
      ffmpeg \
      libcurl4-openssl-dev \
      libzip-dev \
    # Install Imagick via PECL and enable it
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    # Configure GD extension with JPEG and Freetype support
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    # Install PHP extensions (one per line for clarity)
    && docker-php-ext-install pdo \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install xml \
    && docker-php-ext-install simplexml \
    && docker-php-ext-install zip \
    && docker-php-ext-install intl \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install gd \
    && docker-php-ext-install exif \
    && docker-php-ext-install opcache \
    && docker-php-ext-install fileinfo \
    && docker-php-ext-install pcntl \
    # Clean up apt cache to reduce image size
    && rm -rf /var/lib/apt/lists/*

# ─── Apache Configuration ──────────────────────────────────────────────────────
# Copy Apache global configuration snippets and site config, then set permissions and enable site
COPY ./docker/apache/apache2/conf/*.conf /etc/apache2/conf-available/
COPY ./docker/apache/apache2/conf/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN chmod 644 /etc/apache2/conf-available/*.conf \
    && a2ensite 000-default.conf

# Enable Apache confs and required modules, then validate configuration
RUN set -eux; \
    for cfg in /etc/apache2/conf-available/*.conf; do \
      a2enconf "$(basename "$cfg")"; \
    done; \
    a2enmod headers rewrite ssl; \
    apache2ctl configtest

# ─── Application Code and Permissions ──────────────────────────────────────────
# Copy Composer-installed dependencies and application code, create required dirs, and set permissions
COPY --from=deps /app /var/www/html
COPY ./app /var/www/html
RUN mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html \
    && find storage bootstrap/cache -type d -exec chmod 775 {} \; \
    && find storage bootstrap/cache -type f -exec chmod 664 {} \;

# Set working directory for the application
WORKDIR /var/www/html

# ─── Healthcheck and Entrypoint ────────────────────────────────────────────────
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s \
  CMD curl -f http://localhost/ || exit 1

EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
# ──────────────────────────────────────────────────────────────────────────────