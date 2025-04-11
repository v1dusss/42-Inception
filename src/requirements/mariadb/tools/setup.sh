#!/bin/bash

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing MariaDB database..."
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

echo "Starting MariaDB..."
/usr/bin/mysqld_safe --user=mysql &

# Wait for MariaDB to be ready
until mysqladmin ping -h localhost --silent; do
  echo "Waiting for MariaDB to be ready..."
  sleep 1
done

echo "Creating database and users..."
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

echo "MariaDB setup completed."
exec mysqld --user=mysql
