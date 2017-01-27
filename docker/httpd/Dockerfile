FROM reynierpm/docker-centos7-supervisord:latest
MAINTAINER Reynier Perez <reynierpm@gmail.com>
RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
RUN yum install -y httpd24u && \
    yum clean all && rm -rf /tmp/yum*
RUN rm -f /etc/httpd/conf/httpd.conf /etc/httpd/conf.d/* /etc/httpd/conf.modules.d/*
COPY container-files /
EXPOSE 80
