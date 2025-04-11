#!/bin/sh

# Create SSL directory first
mkdir -p /etc/nginx/ssl

# Generate certificates
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/ssl.key \
    -out /etc/nginx/ssl/ssl.crt \
    -subj "/C=DE/ST=BW/L=HB/O=42/CN=vsivanat.42.fr"

# Start Nginx
nginx -g "daemon off;"
