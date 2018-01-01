#!/bin/sh
if [[ -z $SERVER_NAME ]]; then
    SERVER_NAME="_"
fi
sed -i "s/YOUR_SERVER_HERE/${SERVER_NAME}/" /etc/nginx/conf.d/site.conf
nginx -g 'daemon off;'
