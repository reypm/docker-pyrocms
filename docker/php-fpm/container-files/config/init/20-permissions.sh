#!/bin/sh

set -e

# This script will be placed in /config/init/ and run when container starts.
printf "\n===============Setting up permissions started===============\n"
usermod -u 1000 apache && groupmod -g 1000 apache && \
usermod -a -G root apache && \
chown -R apache:root /data/www/pyrocms && \
find /data/www/pyrocms/public/app -type d -print0 -exec chmod 777 {} \; && \
find /data/www/pyrocms/storage -type d -print0 -exec chmod 777 {} \; && \
find /data/www/pyrocms/bootstrap/cache -type d -print0 -exec chmod 777 {} \;
printf "\n===============Setting up permissions finished=============\n"

exec "$@"
