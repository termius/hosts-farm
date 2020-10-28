FROM centos:centos6

RUN yum install telnet telnet-server -y && \
  yum install -y tmux byobu emacs vim mc htop curl

ADD telnet /etc/xinetd.d/
ADD entrypoint.sh /usr/bin/entrypoint.sh

RUN chkconfig telnet on
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT /usr/bin/entrypoint.sh