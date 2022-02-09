FROM ubuntu:20.04

RUN apt-get update -y && apt-get install -y locales && \
  locale-gen en_US.UTF-8 && update-locale LC_ALL="en_US.UTF-8"
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y openssh-server gettext-base syslog-ng \
    tmux byobu emacs vim mc htop curl \
    bb cmatrix libaa-bin \
    zsh git

RUN curl -O 'https://raw.githubusercontent.com/authy/authy-ssh/master/authy-ssh'

ADD authypass/entrypoint.sh /usr/bin/entrypoint.sh
ADD authypass/sshd_config /etc/ssh/sshd_config
ADD authypass/set_password.sh /usr/bin/set_password.sh
ADD zshrc /tmp/

RUN chmod +x /usr/bin/entrypoint.sh /usr/bin/set_password.sh
ENTRYPOINT /usr/bin/entrypoint.sh
CMD /usr/sbin/sshd -D
