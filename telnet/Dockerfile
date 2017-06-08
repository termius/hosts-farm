FROM centos:centos6

RUN yum install telnet telnet-server -y

ADD telnet /etc/xinetd.d/
ADD entrypoint.sh /usr/bin/entrypoint.sh

RUN chkconfig telnet on
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT /usr/bin/entrypoint.sh