FROM ubuntu:14.04

RUN apt-get install -y openssh-server
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD sshd_config /etc/ssh/sshd_config
ADD id_ed25519.pub /tmp/id_ed25519.pub
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT /usr/bin/entrypoint.sh
CMD /usr/sbin/sshd -D
