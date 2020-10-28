FROM ubuntu:18.04

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y openssh-server gettext-base syslog-ng \
    tmux byobu emacs vim mc htop curl

RUN apt-get install -y python

ADD gateway-ports/http.py /opt/http/http.py
ADD gateway-ports/entrypoint.sh /usr/bin/entrypoint.sh
ADD gateway-ports/sshd_config /etc/ssh/sshd_config
ADD keys /tmp/

RUN chmod +x /usr/bin/entrypoint.sh
CMD /usr/bin/entrypoint.sh
