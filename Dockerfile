# Base image - alpine linux
FROM alpine:3.7

# hi. je suis ohnx.
MAINTAINER ohnx <me@masonx.ca>

# commands to run:
#   update package repo
#   install sed
#   install nginx
#   make /run/nginx so that the pid can be placed there
#   make /etc/letsencrypt (will be populated with certs for ssl)
RUN apk update && \
    apk add sed && \
    apk add nginx && \
    mkdir /run/nginx && \
    mkdir /etc/letsencrypt

# configuration
COPY site.conf /etc/nginx/conf.d/
COPY patch-run.sh /usr/bin

# user sites
VOLUME /root
VOLUME /home

# ssl
VOLUME /etc/letsencrypt

# nginx
EXPOSE 443
EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["patch-run.sh"]
