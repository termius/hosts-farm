FROM ubuntu:18.04
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y curl
RUN apt-get install -y curl openssh-server

RUN apt-get install -y autoconf libtool libpam-dev libssl-dev make
RUN wget https://dl.duosecurity.com/duo_unix-latest.tar.gz \
&& tar zxf duo_unix-latest.tar.gz \
&& cd duo_unix-1.11.3 \
&& ./configure --with-pam --prefix=/usr && make && make install

RUN apt-get install -y syslog-ng

ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD sshd_config /etc/ssh/sshd_config
ADD id_rsa.pub /tmp/id_rsa.pub

RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e"]
