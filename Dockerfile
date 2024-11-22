FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /etc/bgpalerter

COPY config.yml /etc/bgpalerter

CMD ["/etc/start.sh"]
