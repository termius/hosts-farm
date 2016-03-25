FROM ubuntu:14.04

RUN \
    apt-get update && \
    apt-get install -y openssh-server && \
    apt-get install -y otpw-bin libpam-otpw
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD sshd_config /etc/ssh/sshd_config
ADD pam_sshd /etc/pam.d/sshd
ADD otpw /tmp/otpw

RUN chmod +x /usr/bin/entrypoint.sh
CMD /usr/bin/entrypoint.sh
