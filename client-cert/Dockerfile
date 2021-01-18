FROM ubuntu:18.04

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y openssh-server gettext-base syslog-ng \
    tmux byobu emacs vim mc htop curl

ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD sshd_config /etc/ssh/sshd_config
ADD ca.pub /etc/ssh/ca.pub

RUN chmod +x /usr/bin/entrypoint.sh
CMD /usr/bin/entrypoint.sh
