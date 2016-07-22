FROM ubuntu:14.04

RUN apt-get install -y openssh-server
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD sshd_config /etc/ssh/sshd_config
ADD id_ecdsa.pub /tmp/id_ecdsa.pub
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT /usr/bin/entrypoint.sh
CMD /usr/sbin/sshd -D
