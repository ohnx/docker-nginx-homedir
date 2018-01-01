#!/bin/sh
/usr/bin/sed -i "s/YOUR_SERVER_HERE/${SERVER_NAME}/" /etc/nginx/conf.d/site.conf
nginx -g daemon off
