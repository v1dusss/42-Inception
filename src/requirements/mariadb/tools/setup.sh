#!/bin/bash

echo "Starting MariaDB service..."
service mysql start

echo "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" > temp.sql
echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> temp.sql
echo "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';" >> temp.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> temp.sql
echo "FLUSH PRIVILEGES;" >> temp.sql

mysql < temp.sql

rm temp.sql

echo "Starting MariaDB in the foreground..."