FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	nginx \
	openssl

COPY ./conf/default.conf /etc/nginx/nginx.conf
COPY ./tools/setup.sh /

RUN chmod +x /setup.sh

EXPOSE 443

ENTRYPOINT ["/setup.sh"]