FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php-fpm \
	php-mysqli \
	curl \
	mariadb-client

COPY tools/setup.sh .
RUN chmod +x setup.sh

# WORKDIR /var/www/html
# EXPOSE 9000

ENTRYPOINT ["./setup.sh"]