FROM ubuntu:18.04

#####################################
# Install packages
#####################################
RUN apt-get update
RUN apt-get install -y build-essential libssl-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y zfsutils-linux 
RUN apt-get install -y openssh-server
RUN apt-get install -y knockd
RUN apt-get install -y ufw
RUN apt-get install -y apt-utils



COPY portknocking/install-modprobe.sh /usr/bin/
RUN chmod +x /usr/bin/install-modprobe.sh
# RUN /usr/bin/install-modprobe.sh


COPY portknocking/knockd /etc/default/
COPY portknocking/knockd.conf /etc/
COPY portknocking/knockd.log /var/log/

ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD portknocking/sshd_config /etc/ssh/sshd_config

RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]


CMD bash -c '/usr/bin/install-modprobe.sh; ufw enable; service knockd start; /usr/sbin/sshd -D'



