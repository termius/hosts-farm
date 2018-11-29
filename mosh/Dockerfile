FROM ubuntu:18.04

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y openssh-server mosh locales

RUN locale-gen en_US.UTF-8

ADD mosh/entrypoint.sh /usr/bin/entrypoint.sh
ADD mosh/sshd_config /etc/ssh/sshd_config
ADD keys /tmp/

RUN chmod +x /usr/bin/entrypoint.sh
CMD /usr/bin/entrypoint.sh
