FROM amazonlinux:2023
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Base packages
RUN dnf install -y glibc-langpack-en openssh-server shadow-utils bash openssl && \
    dnf clean all && \
    mkdir -p /var/run/sshd

COPY amazon-linux/sshd_config /etc/ssh/sshd_config
COPY amazon-linux/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 22
CMD ["/usr/bin/entrypoint.sh"]
