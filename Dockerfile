FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get install wget curl net-tools -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /etc/bgpalerter

COPY start.sh /etc

CMD ["/etc/start.sh"]
