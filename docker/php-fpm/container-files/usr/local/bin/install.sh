#!/bin/sh

set -e

# Install Xdebug
if  [ "$INSTALL_XDEBUG" == "true" ]; then
    printf "\nInstalling Xdebug ...\n"
    yum install -y  php71-php-pecl-xdebug
fi

# Install Mongo
if  [ "$INSTALL_MONGO" == "true" ]; then
    printf "\nInstalling Mongo ...\n"
    yum install -y  php71-php-pecl-mongodb
fi

# Install Redis
if  [ "$INSTALL_REDIS" == "true" ]; then
    printf "\nInstalling Redis ...\n"
    yum install -y  php71-php-pecl-redis
fi

# Install Extended HTTP Support
if  [ "$INSTALL_HTTP_REQUEST" == "true" ]; then
    printf "\nInstalling Extended HTTP Support ...\n"
    yum install -y  php71-php-pecl-request
fi

# Install Upload Progress
if  [ "$INSTALL_UPLOAD_PROGRESS" == "true" ]; then
    printf "\nInstalling Upload Progress ...\n"
    yum install -y  php71-php-pecl-uploadprogress
fi

# Install Extended Attributes
if  [ "$INSTALL_XATTR" == "true" ]; then
    printf "\nInstalling Extended Attributes ...\n"
    yum install -y  php71-php-pecl-xattr
fi

# Install Composer
EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quit --install-dir=/usr/local/bin --filename=composer
RESULT=$?
rm composer-setup.php

export PATH="/root/.composer/vendor/bin:${PATH}"
export COMPOSER_ALLOW_SUPERUSER=1
export COMPOSER_HOME="/root/.composer"
export COMPOSER_CACHE_DIR="/root/.composer/cache"

if  [ "$INSTALL_XDEBUG" == "true" ]; then
    export COMPOSER_ALLOW_XDEBUG=1
    export COMPOSER_DISABLE_XDEBUG_WARN=1
fi


# Install Symfony Installer
if  [ "$SYMFONY_INSTALLER" == "true" ]; then
    curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony && \
    chmod a+x /usr/local/bin/symfony
fi

exec "$@"
