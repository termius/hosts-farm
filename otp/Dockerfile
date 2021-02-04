FROM ubuntu:18.04

RUN apt-get update -y && apt-get install -y locales && \
  locale-gen en_US.UTF-8 && update-locale LC_ALL="en_US.UTF-8"
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y openssh-server gettext-base syslog-ng \
    tmux byobu emacs vim mc htop curl \
    bb cmatrix libaa-bin

RUN apt-get install -y otpw-bin libpam-otpw

ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD sshd_config /etc/ssh/sshd_config
ADD pam_sshd /etc/pam.d/sshd
ADD otpw /tmp/otpw

RUN chmod +x /usr/bin/entrypoint.sh
CMD /usr/bin/entrypoint.sh
