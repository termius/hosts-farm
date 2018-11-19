FROM ubuntu:14.04

RUN apt-get update && apt-get install -y squid
COPY squid.conf /etc/squid3/squid.conf
EXPOSE 3128
CMD ["squid3", "-N"]
