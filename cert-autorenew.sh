#!/bin/sh
# renew the cert
certbot renew --quiet

# reload nginx configuration if the cert was changed
nginx -s reload
