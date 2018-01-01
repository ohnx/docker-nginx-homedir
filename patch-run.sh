#!/bin/sh
if [[ -z $SERVER_NAME ]]; then echo "Please specify a SERVER_NAME using environment variables."; exit 1; fi

# replace server name with proper server name in config
sed -i "s/YOUR_SERVER_HERE/${SERVER_NAME}/" /etc/nginx/conf.d/site.conf

# start nginx
echo -n "Starting nginx... "
nginx -g 'daemon off;'
