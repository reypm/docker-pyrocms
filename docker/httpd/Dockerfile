FROM reynierpm/centos7-supervisor
MAINTAINER Reynier Perez <reynierpm@gmail.com>
RUN yum install -y httpd nano && \
    yum clean all && rm -rf /tmp/yum*
RUN rm -f /etc/httpd/conf/httpd.conf /etc/httpd/conf.d/* /etc/httpd/conf.modules.d/*
COPY container-files /
EXPOSE 80
