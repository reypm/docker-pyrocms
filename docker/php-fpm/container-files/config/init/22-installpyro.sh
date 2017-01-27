#!/bin/sh

set -e

# This script will install PyroCMS.
printf "\n===============Install PyroCMS started===============\n"
cd /data/www/pyrocms/
php artisan install --ready
printf "\n===============Install PyroCMS finished=============\n"

exec "$@"
