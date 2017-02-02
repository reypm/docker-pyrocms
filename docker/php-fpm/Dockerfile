FROM reynierpm/centos7-supervisor
MAINTAINER Reynier Perez <reynierpm@gmail.com>
ENV TERM=xterm
ARG INSTALL_COMPOSER="false"
ARG INSTALL_XDEBUG="false"
ARG INSTALL_MONGO="false"
ARG INSTALL_REDIS="false"
ARG INSTALL_HTTP_REQUEST="false"
ARG INSTALL_UPLOAD_PROGRESS="false"
ARG INSTALL_XATTR="false"

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
                   https://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum install -y  \
        yum-utils \
        git \
        zip \
        unzip \
        nano \
        wget \
        php71-php-fpm \
        php71-php-cli \
        php71-php-common \
        php71-php-gd \
        php71-php-intl \
        php71-php-json \
        php71-php-mbstring \
        php71-php-mcrypt \
        php71-php-mysqlnd \
        php71-php-pdo \
        php71-php-pear \
        php71-php-xml \
        php71-pecl-apcu \
        php71-php-pecl-apfd \
        php71-php-pecl-memcache \
        php71-php-pecl-memcached \
        php71-php-pecl-zip && \
        yum clean all && rm -rf /tmp/yum*

RUN ln -sfF /opt/remi/php71/enable /etc/profile.d/php71-paths.sh && \
    ln -sfF /opt/remi/php71/root/usr/bin/{pear,pecl,phar,php,php-cgi,phpize} /usr/local/bin/. && \
    mv -f /etc/opt/remi/php71/php.ini /etc/php.ini && \
    ln -s /etc/php.ini /etc/opt/remi/php71/php.ini && \
    rm -rf /etc/php.d && \
    mv /etc/opt/remi/php71/php.d /etc/. && \
    ln -s /etc/php.d /etc/opt/remi/php71/php.d

COPY container-files /

RUN sh /usr/local/bin/install.sh && \
    chmod +x /config/bootstrap.sh

WORKDIR /data/www
VOLUME ["/data/www"]
EXPOSE 9001
