FROM debian:bullseye

RUN apt-get update && apt-get install -y nano

COPY ./tools/script.sh /

RUN chmod +x /script.sh

RUN bash /script.sh

CMD tail -f /dev/null