FROM ubuntu:22.04

RUN apt-get update && apt-get install locales && \
  locale-gen en_US.UTF-8 && update-locale LC_ALL="en_US.UTF-8"
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y openssh-server dropbear gettext-base syslog-ng \
    vttest tmux byobu emacs vim mc htop curl nano \
    bb cmatrix libaa-bin \
    zsh git

ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD sshd_configs_raw /tmp/
ADD keys /tmp/
ADD dropbear/dropbear_config /etc/config/dropbear
ADD zshrc /tmp/

RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD dropbear -w -s -G remote -F -r ${DROPBEAR_KEY_FILE:-/etc/dropbear/dropbear_rsa_host_key}
