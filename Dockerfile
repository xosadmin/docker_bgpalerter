FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /etc/bgpalerter && mkdir /opt/data

CMD ["/etc/start.sh"]
