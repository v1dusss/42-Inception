FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	apache2 \
	php7.4 \
	php7.4-mysql \
	wget \
	unzip \
	netcat \
	curl

COPY tools/setup.sh setup.sh
RUN chmod +x setup.sh

ENTRYPOINT [ "./setup.sh" ]