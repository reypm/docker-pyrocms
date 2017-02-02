#!/bin/sh

#
# This script will be placed in /config/init/ and run when container starts.
# It creates (if they're not exist yet) necessary Nginx directories
# @see /etc/nginx/addon.d/fastcgi-cache.example
#

set -e

mkdir -p /data/php/{sessions,xdebug,logs,uploads}
