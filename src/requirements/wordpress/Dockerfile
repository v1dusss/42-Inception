FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php-fpm \
	php-mysqli \
	php-curl \
	php-dom \
	php-imagick \
	php-mbstring \
	php-zip \
	php-gd \
	php-intl \
	curl \
	mariadb-client

COPY tools/setup.sh .
RUN chmod +x setup.sh

ENTRYPOINT ["./setup.sh"]