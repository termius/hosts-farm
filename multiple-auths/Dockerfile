FROM ubuntu:22.04

RUN apt-get update -y && apt-get install -y locales && \
  locale-gen en_US.UTF-8 && update-locale LC_ALL="en_US.UTF-8"
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y openssh-server gettext-base syslog-ng \
    vttest tmux byobu emacs vim mc htop curl nano \
    bb cmatrix libaa-bin \
    zsh git

ADD multiple-auths/entrypoint.sh /usr/bin/entrypoint.sh
ADD multiple-auths/sshd_config /etc/ssh/sshd_config
ADD keys /tmp/
ADD zshrc /tmp/

RUN chmod +x /usr/bin/entrypoint.sh
CMD /usr/bin/entrypoint.sh
