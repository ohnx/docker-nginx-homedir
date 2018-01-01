# Base image - alpine linux
FROM alpine:3.7

# hi. je suis ohnx.
MAINTAINER ohnx <me@masonx.ca>

# commands to run:
#   update package repo
#   install nginx
#   make /run/nginx so that the pid can be placed there
#   make /etc/letsencrypt (will be populated with certs for ssl)
RUN apk update && \
    apk add nginx && \
    mkdir /run/nginx && \
    mkdir /etc/letsencrypt

# configuration
COPY site.conf /etc/nginx/conf.d/

# user sites
VOLUME /root
VOLUME /home

# ssl
VOLUME /etc/letsencrypt

# nginx
EXPOSE 443
EXPOSE 80

# sFTP server
EXPOSE 22

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]

