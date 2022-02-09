FROM ubuntu:20.04

RUN apt-get update && apt-get install locales && \
  locale-gen en_US.UTF-8 && update-locale LC_ALL="en_US.UTF-8"
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y tinysshd ucspi-tcp syslog-ng \
    tmux byobu emacs vim mc htop curl \
    bb cmatrix libaa-bin \
    zsh git

ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD sshd_configs_raw /tmp/
ADD keys /tmp/
RUN chmod +x /usr/bin/entrypoint.sh
ADD sanitize-auth-log.sh /usr/bin/sanitize-auth-log.sh
RUN chmod +x /usr/bin/sanitize-auth-log.sh
RUN tinysshd-makekey /etc/tinyssh/sshkeydir
ADD zshrc /tmp/

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD tcpserver -HRDl0 0.0.0.0 22 /usr/sbin/tinysshd -v -s /etc/tinyssh/sshkeydir
