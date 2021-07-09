FROM ubuntu:20.04

RUN apt-get update -y && apt-get install -y locales && \
  locale-gen en_US.UTF-8 && update-locale LC_ALL="en_US.UTF-8"
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y squid
ARG SQUID_CONFIG=squid.conf
COPY $SQUID_CONFIG /etc/squid/squid.conf
COPY squid-passwords /etc/squid/passwords
EXPOSE 3128
CMD ["squid", "-N"]
