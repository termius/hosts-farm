FROM ubuntu:14.04

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y curl
RUN \
    apt-get update && \
    apt-get install -y openssh-server && \
    apt-get install -y libpam-yubico
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD sshd_config /etc/ssh/sshd_config
ADD pam_sshd /etc/pam.d/sshd
ADD yubico_passw /var/yubico_passw

RUN chmod +x /usr/bin/entrypoint.sh
CMD /usr/bin/entrypoint.sh

