FROM rockylinux:9

RUN dnf upgrade -y --refresh

RUN dnf install -y 'dnf-command(config-manager)'

RUN dnf config-manager --set-enabled crb
RUN dnf install -y epel-release

RUN dnf install -y openssh-server
RUN dnf install -y git
RUN dnf install -y pass

ADD rocky/sshd_config /tmp/
ADD keys /tmp/

ADD rocky/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ADD zshrc /tmp/

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD /usr/sbin/sshd -D
