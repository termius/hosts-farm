# Copyright (c) 2022 Termius Corporation.
FROM ubuntu:20.04 as builder

RUN mkdir /app && apt-get update -y && apt-get upgrade -y && apt-get install -y gcc libpam0g-dev
ADD keyboard-interactive-custom/termius-pam.c /app/termius-pam.c
WORKDIR /app/
RUN gcc -fPIC -c termius-pam.c && gcc -shared -o termius-pam.so termius-pam.o -lpam

FROM ubuntu:20.04

RUN apt-get update -y && apt-get install -y locales && \
  locale-gen en_US.UTF-8 && update-locale LC_ALL="en_US.UTF-8"
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y openssh-server gettext-base syslog-ng \
    tmux byobu emacs vim mc htop curl \
    bb cmatrix libaa-bin \
    libpam-python

ADD keyboard-interactive-pass/entrypoint.sh /usr/bin/entrypoint.sh
ADD keyboard-interactive-pass/sshd_config /etc/ssh/sshd_config
ADD keyboard-interactive-custom/pam_sshd /etc/pam.d/sshd
COPY --from=builder /app/termius-pam.so /lib/security/termius-pam.so
ADD zshrc /tmp/

RUN chmod +x /usr/bin/entrypoint.sh
CMD /usr/bin/entrypoint.sh
