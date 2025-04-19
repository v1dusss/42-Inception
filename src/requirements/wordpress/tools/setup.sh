#!/bin/sh

mkdir -p /run/php

rm -f /usr/local/bin/wp

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
chown www-data:www-data /usr/local/bin/wp

mkdir -p /var/www/html/$DOMAIN_NAME/public_html
chown -R www-data:www-data /var/www/html/$DOMAIN_NAME/public_html
chmod -R 755 /var/www/html/vsivanat.42.fr/public_html

WP_PATH="/var/www/html/$DOMAIN_NAME/public_html"
wp core download --path=$WP_PATH --allow-root

echo "[WORDPRESS][DEBUG] WP_PATH: ${WP_PATH}"
cd $WP_PATH

wp config create\
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost="mariadb" \
    --path=$WP_PATH \
    --allow-root

echo "[WORDPRESS] Database Check"
until wp db check --allow-root; do
  echo "[WORDPRESS] Waiting for MariaDB to be ready..."
  sleep 5
done

echo "[WORDPRESS] Database is ready."
echo "[WORDPRESS] Installing WordPress..."
wp core install \
    --path=$WP_PATH \
    --url=$DOMAIN_NAME \
    --title='42-Inception' \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email='email@domain.com' \
    --allow-root

wp user create $WP_USER \
    $WP_USER_EMAIL \
    --user_pass=$WP_USER_PASSWORD \
    --allow-root

sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|g' /etc/php/7.4/fpm/pool.d/www.conf

echo "[WORDPRESS] WordPress is installed and configured."

exec php-fpm7.4 --nodaemonize
