ARG UBUNTU_VERSION=22.04
FROM ubuntu:${UBUNTU_VERSION}

RUN apt-get update -y && apt-get install -y locales && \
  locale-gen en_US.UTF-8 && update-locale LC_ALL="en_US.UTF-8"
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y gettext-base syslog-ng \
    vttest tmux byobu emacs vim mc htop curl nano \
    bb cmatrix libaa-bin \
    zsh git build-essential autoconf zlib1g-dev libssl-dev

RUN git clone https://github.com/openssh/openssh-portable.git --depth 1 --branch V_10_0_P2 \
    && cd openssh-portable \
    && autoreconf \
    && ./configure --prefix=/usr --sysconfdir=/etc/ssh --with-privsep-path=/var/lib/sshd \
    && make -j$(nproc) \
    && make install

ADD sshd_configs_raw /tmp/
ADD keys /tmp/

ADD openssh10/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ADD sanitize-auth-log.sh /usr/bin/sanitize-auth-log.sh
RUN chmod +x /usr/bin/sanitize-auth-log.sh

ADD zshrc /tmp/

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD /usr/sbin/sshd -D
