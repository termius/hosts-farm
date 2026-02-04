FROM ubuntu:22.04

RUN apt-get update -y && apt-get install -y locales && \
  locale-gen en_US.UTF-8 && update-locale LC_ALL="en_US.UTF-8"
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y xinetd gettext-base syslog-ng \
    tmux byobu emacs vim mc htop curl nano \
    bb cmatrix libaa-bin \
    zsh git \
    build-essential autoconf automake libtool texinfo libncurses-dev libreadline-dev \
    bison help2man

# Clone inetutils and build telnetd from source with patch
WORKDIR /tmp/inetutils-build
RUN git clone https://git.savannah.gnu.org/git/inetutils.git . && \
  ./bootstrap && \
  ./configure --prefix=/usr --localstatedir=/var --sysconfdir=/etc

# Apply patch to disable IAC WILL ECHO
COPY telnet-echo-issue/apply-patch.sh /tmp/
RUN chmod +x /tmp/apply-patch.sh && /tmp/apply-patch.sh

# Build and install telnetd (need to build dependencies first)
RUN cd /tmp/inetutils-build && \
  make -C lib && \
  make -C libinetutils && \
  make -C libtelnet && \
  make -C telnetd && \
  make -C telnetd install && \
  ls -la /usr/libexec/telnetd

# Ensure telnetd is named in.telnetd and in the expected location for xinetd
RUN mv /usr/libexec/telnetd /usr/libexec/in.telnetd && \
  ln -s /usr/libexec/in.telnetd /usr/sbin/in.telnetd && \
  ls -la /usr/sbin/in.telnetd

WORKDIR /

ADD telnet-echo-issue/telnet /etc/xinetd.d/
ADD telnet-echo-issue/entrypoint.sh /usr/bin/entrypoint.sh

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT /usr/bin/entrypoint.sh
