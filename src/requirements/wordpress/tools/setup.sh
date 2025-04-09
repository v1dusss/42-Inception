#!/bin/sh

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.pharchmod +x wp-cli.phar

mv wp-cli.phar /user/local/bin/wp

wp config create\
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost="mariadb" \
    --path=/var/www/html/ \
    --allow-root
