FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server

COPY ./tools/setup.sh /
RUN chmod +x /setup.sh

# 3306 is the default port for MariaDB
EXPOSE 3306

ENTRYPOINT ["/setup.sh"]
