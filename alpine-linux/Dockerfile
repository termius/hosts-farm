FROM alpine:3.20
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

RUN apk add --no-cache \
      bash \
      openssh \
      shadow \
      openssl && \
    mkdir -p /var/run/sshd

COPY alpine-linux/sshd_config /etc/ssh/sshd_config
COPY alpine-linux/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 22
CMD ["/usr/bin/entrypoint.sh"]
