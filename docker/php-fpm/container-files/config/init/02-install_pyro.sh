#!/bin/sh

set -e

#
# This script will be placed in /config/init/ and run when container starts.
# It copy the necessary files and install PyroCMS
#

DATA_DIR="/data/www"
PYRO_DIR="$DATA_DIR/pyrocms"

printf "\nBe patient we're installing PyroCMS .... it will take a few minutes ...\n"

if [ ! -d "$DATA_DIR" ]; then
    mkdir -p "$DATA_DIR"
fi

if  [ "$(ls -la "$DATA_DIR")" ]; then
    rm -rf "$DATA_DIR/*"
fi

cd "$DATA_DIR"
composer create-project pyrocms/pyrocms
mv /tmp/.env "$PYRO_DIR"/.env
cd "$PYRO_DIR"
php artisan install --ready

# Remove the .htaccess file shipped with Pyro since we've tunned our VH file
rm -f "$PYRO_DIR/public/.htaccess"

usermod -u 1000 apache && groupmod -g 1000 apache && \
chown -R apache:root $DATA_DIR

find "$PYRO_DIR"/public/app -type d -print0 -exec chmod 777 {} \; && \
find "$PYRO_DIR"/storage -type d -print0 -exec chmod 777 {} \; && \
find "$PYRO_DIR"/bootstrap/cache -type d -print0 -exec chmod 777 {} \;

exec "$@"
