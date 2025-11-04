FROM rockylinux:9.3.20231119-minimal

ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

RUN microdnf install -y openssh-server shadow-utils && \
    microdnf clean all && \
    mkdir -p /var/run/sshd

# Put your sshd_config directly in place
COPY amazon-linux/sshd_config /etc/ssh/sshd_config

# Minimal entrypoint: create user, set password, start sshd
COPY amazon-linux/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 22
CMD ["/usr/bin/entrypoint.sh"]
