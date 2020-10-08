FROM ubuntu:18.04

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y openssh-server gettext-base syslog-ng \
    tmux byobu emacs vim mc htop curl

ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD sshd_configs_raw /tmp/
ADD keys /tmp/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD /usr/sbin/sshd -D
