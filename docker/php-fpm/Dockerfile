FROM reynierpm/docker-centos7-supervisord:latest
MAINTAINER Reynier Perez <reynierpm@gmail.com>
ENV TERM=xterm \
    PATH="/root/.composer/vendor/bin:${PATH}" \
    COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME="/root/.composer" \
    COMPOSER_CACHE_DIR="/root/.composer/cache"

# Install and configure PHP 7.1.1
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
                   https://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum install -y  \
        yum-utils \
        git \
        zip \
        unzip \
        wget \
        nano \
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
        php71-php-pecl-mongodb \
        php71-php-pecl-redis \
        php71-php-pecl-request \
        php71-php-pecl-uploadprogress \
        php71-php-pecl-xattr \
        php71-php-pecl-zip && \
        yum clean all && rm -rf /tmp/yum*
RUN ln -sfF /opt/remi/php71/enable /etc/profile.d/php71-paths.sh && \
    ln -sfF /opt/remi/php71/root/usr/bin/{pear,pecl,phar,php,php-cgi,phpize} /usr/local/bin/. && \
    mv -f /etc/opt/remi/php71/php.ini /etc/php.ini && \
    ln -sfF /etc/php.ini /etc/opt/remi/php71/php.ini && \
    rm -rf /etc/php.d && \
    mv /etc/opt/remi/php71/php.d /etc/. && \
    ln -sfF /etc/php.d /etc/opt/remi/php71/php.d

RUN /bin/sh -c "mkdir -p /data/www" && \
    /bin/sh -c "mkdir -p /data/php/{tmp,sessions,xdebug,logs,uploads}" && \
    rm -rf /data/www/*
COPY container-files /
WORKDIR /data/www
RUN sh /usr/local/bin/composer-install.sh && \
    composer create-project pyrocms/pyrocms
COPY .env /data/www/pyrocms/.env
RUN chmod +x /config/bootstrap.sh
WORKDIR /data/www/pyrocms
VOLUME /data/www
EXPOSE 9005
