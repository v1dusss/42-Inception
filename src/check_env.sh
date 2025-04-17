#!/bin/sh

# Check if .env file exists
if [ ! -f src/.env ]; then
	echo ".env file not found!"
	exit 1
fi

. src/.env

# List of required variables
required_vars="DOMAIN_NAME MYSQL_ROOT_PASSWORD MYSQL_DATABASE MYSQL_USER MYSQL_PASSWORD WP_ADMIN_USER WP_ADMIN_PASSWORD WP_USER WP_USER_EMAIL WP_USER_PASSWORD"

# Check if each required variable is set
for var in $required_vars; do
	eval val="\$$var"
	if [ -z "$val" ]; then
		echo "Error: $var is not set in .env"
		exit 1
	fi
done

# Check if WP_ADMIN_USER contains 'admin'
if echo "$WP_ADMIN_USER" | grep -iq "admin"; then
	echo "Error: WP_ADMIN_USER should not contain the word 'admin'"
	exit 1
fi

echo "All checks passed."
