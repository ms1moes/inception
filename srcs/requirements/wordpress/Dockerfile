FROM debian:bullseye

# Update and install necessary packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client netcat

# Create and set permissions for wp-cli cache directory
RUN mkdir -p /var/www/.wp-cli/cache/ && \
    chown -R www-data:www-data /var/www/.wp-cli

# Configure PHP-FPM
RUN sed -i 's/user = www-data/user = www-data/g' /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i 's/group = www-data/group = www-data/g' /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i 's#error_log = /var/log/php7.4-fpm.log#error_log = /var/log/php7.4-fpm/php7.4-fpm.log#' /etc/php/7.4/fpm/php-fpm.conf && \
    sed -i 's#;error_log = php_errors.log#error_log = /var/log/php7.4-fpm/php_errors.log#' /etc/php/7.4/fpm/php.ini

# Create and set permissions for necessary directories
RUN mkdir -p /run/php && \
    chown -R www-data:www-data /run/php && \
    mkdir -p /var/log/php7.4-fpm && \
    touch /var/log/php7.4-fpm.log && \
    chown -R www-data:www-data /var/log/php7.4-fpm && \
    chmod 755 /var/log/php7.4-fpm && \
    chmod 644 /var/log/php7.4-fpm.log

# WordPress setup
RUN mkdir -p /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress
RUN chmod -R 755 /var/www/wordpress

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY conf/wp-init.sh .
RUN chmod +x wp-init.sh

USER www-data
ENV HOME=/var/www

ENTRYPOINT ["./wp-init.sh"]
