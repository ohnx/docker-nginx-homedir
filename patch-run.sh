#!/bin/sh
if [[ -z $SERVER_NAME ]]; then echo "Please specify a SERVER_NAME using environment variables."; exit 1; fi
if [[ -z $WEBMASTER_EMAIL ]]; then echo "Please specify the webmaster's email using the WEBMASTER_EMAIL environment variable"; exit 2; fi

set -e

# replace server name with proper server name in config
sed -i "s/YOUR_SERVER_HERE/${SERVER_NAME}/" /etc/nginx/conf.d/site.conf

# SSL config
sed -i "s/#SSLTMP/       /" /etc/nginx/conf.d/site.conf

# start nginx without SSL first
echo -n "Starting nginx to get certificates... "
nginx
echo "done!"

# get certificates
mkdir -p /tmp/sslconfig/.well-known
echo -n "Requesting certificates... "
certbot certonly --webroot -w /tmp/sslconfig -d $SERVER_NAME --email=$WEBMASTER_EMAIL --noninteractive --quiet --agree-tos
echo "done!"

# stop nginx
echo -n "Stopping nginx... "
nginx -s stop
echo "done!"

# enable SSL
echo -n "Enabling SSL... "
sed -i "s/#SSLOFF/       /" /etc/nginx/conf.d/site.conf
echo "done!"

# start nginx again
echo -n "Restarting nginx... "
nginx -g 'daemon off;'
