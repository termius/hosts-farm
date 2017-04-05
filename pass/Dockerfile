FROM ubuntu:14.04

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y openssh-server
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD sshd_config /etc/ssh/sshd_config

RUN chmod +x /usr/bin/entrypoint.sh
CMD /usr/bin/entrypoint.sh
