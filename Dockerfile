FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get install wget curl -y \
    apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /etc/bgpalerter && mkdir /opt/data

COPY start.sh /etc

CMD ["/etc/start.sh"]
