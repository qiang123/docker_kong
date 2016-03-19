FROM ubuntu
COPY sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install netcat openssl libpcre3 dnsmasq procps
RUN apt-get -y install make build-essential
VOLUME ["/etc/kong/", "/build"]
COPY kong-0.7.0release0.7.0.trusty_all.deb /build/

RUN dpkg -i  /build/kong-0.7.0release0.7.0.trusty_all.deb

ENV KONG_VERSION 0.7.0

COPY kong.yml /etc/kong/kong.yml

COPY ukong .

RUN make install

ENV CASSANDRA_ADDR cassandra
CMD kong start

EXPOSE 8000 8443 8001 7946
