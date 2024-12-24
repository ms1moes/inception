#!/bin/bash

WP_DIR=/var/www/wordpress
cd $WP_DIR

wait_db() {
    nc -zv mariadb 3306 2> /dev/null
    return $?
}

while ! wait_db; do
    echo "[========Waiting for the database to be ready========]";
    sleep 1
done

if [ -f ./wp-config.php ]
then
    echo "[========WordPress files already exist. Skipping installation========]"
else
    echo "[========WP INSTALLATION STARTED========]"
    wp core download
    wp core config --dbhost=mariadb:3306 --dbname="$MYSQL_DB" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD"
    wp core install --url="$MY_DOMAIN" --title="$WP_TITLE" --admin_user="$WP_ADMIN_N" --admin_password="$WP_ADMIN_P" --admin_email="$WP_ADMIN_E"
    wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$WP_U_PASS" --role="$WP_U_ROLE"
fi

# Start PHP-FPM
exec /usr/sbin/php-fpm7.4 -F
