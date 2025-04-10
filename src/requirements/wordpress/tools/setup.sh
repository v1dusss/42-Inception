#!/bin/sh

mkdir -p /run/php

rm -f /usr/local/bin/wp

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
chown www-data:www-data /usr/local/bin/wp

mkdir -p /var/www/html/$DOMAIN_NAME/public_html
chown -R www-data:www-data /var/www/html/$DOMAIN_NAME/public_html
chown www-data:www-data /var/www/html/$DOMAIN_NAME/public_html
cd /var/www/html/$DOMAIN_NAME/public_html
WP_PATH="/var/www/html/$DOMAIN_NAME/public_html"
wp core download --path=$WP_PATH --allow-root

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


wp core install \
    --path=$WP_PATH \
    --url=$DOMAIN_NAME \
    --title='42-Inception' \
    --admin_user=$WP_ADMIN_USER \
    --admin_password= $WP_PASSWORD \
    --admin_email='email@domain.com' \
    --allow-root

sed -i "s/listne = .*/listen = 9000/listen = 9001/" /etc/php/8.1/fpm/pool.d/www.conf

exec php-fpm8.1 -F