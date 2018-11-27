FROM ubuntu:14.04

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y openssh-server
ADD agent-forwarding-disabled/entrypoint.sh /usr/bin/entrypoint.sh
ADD agent-forwarding-disabled/sshd_config /etc/ssh/sshd_config
ADD keys /tmp/

RUN chmod +x /usr/bin/entrypoint.sh
CMD /usr/bin/entrypoint.sh
