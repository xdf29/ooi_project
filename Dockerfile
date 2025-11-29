# Use PHP + Nginx + PHP-FPM base — make sure PHP version matches your Laravel
FROM richarvey/nginx-php-fpm:latest

# Install Node + npm
RUN apt-get update && \
    apt-get install -y curl nodejs npm && \
    npm install -g npm@latest

WORKDIR /var/www/html

# Copy project files
COPY . .

# Allow composer as root
ENV COMPOSER_ALLOW_SUPERUSER=1

# Install PHP deps
RUN composer install --no-dev --optimize-autoloader

# Build frontend assets
RUN npm install
RUN npm run build

# Permissions, etc. (if needed)

# Expose port — Render uses 80 internally
EXPOSE 80

# Start server via provided start script
CMD ["/start.sh"]
