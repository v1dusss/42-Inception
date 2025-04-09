FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php7.4 \
	php7.4-fpm \
	php7.4-mysql \
	php7.4-json \
	php7.4-curl \
	php7.4-gd \
	php7.4-mbstring \
	php7.4-xml \
	php7.4-zip \
	wget \
	curl \
	mariadb-client

COPY tools/setup.sh .
RUN chmod +x setup.sh

# WORKDIR /var/www/html
# EXPOSE 9000

ENTRYPOINT ["./setup.sh"]