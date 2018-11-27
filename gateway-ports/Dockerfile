FROM ubuntu:14.04

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y openssh-server python
ADD gateway-ports/http.py /opt/http/http.py
ADD gateway-ports/entrypoint.sh /usr/bin/entrypoint.sh
ADD gateway-ports/sshd_config /etc/ssh/sshd_config
ADD keys /tmp/

RUN chmod +x /usr/bin/entrypoint.sh
CMD /usr/bin/entrypoint.sh
