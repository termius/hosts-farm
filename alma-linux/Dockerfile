FROM almalinux:9-minimal
RUN microdnf install -y glibc-langpack-en openssh-server shadow-utils bash openssl && \
    microdnf clean all && \
    mkdir -p /var/run/sshd
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
COPY alma-linux/sshd_config /etc/ssh/sshd_config
COPY alma-linux/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
EXPOSE 22
CMD ["/usr/bin/entrypoint.sh"]
