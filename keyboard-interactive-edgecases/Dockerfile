FROM ubuntu:22.04

RUN apt-get update -y && apt-get install -y locales && \
  locale-gen en_US.UTF-8 && update-locale LC_ALL="en_US.UTF-8"
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y openssh-server gettext-base syslog-ng \
    tmux byobu emacs vim mc htop curl nano \
    bb cmatrix libaa-bin \
    zsh git

ADD keyboard-interactive-edgecases/sshd_config /tmp
ADD keys /tmp/

ADD keyboard-interactive-edgecases/entrypoint.sh /usr/bin/entrypoint.sh
ADD zshrc /tmp/

RUN chmod +x /usr/bin/entrypoint.sh
CMD /usr/bin/entrypoint.sh
