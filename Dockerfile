# Base image - alpine linux
FROM alpine:3.7

# hi. je suis ohnx.
MAINTAINER ohnx <me@masonx.ca>

# commands to run:
#   update package repo
#   install nginx, sed
#   install certbot, dcron (cron), py2-future, py2-certifi, py2-urllib3, py2-chardet -- only needed for SSL
#   make /run/nginx so that the pid can be placed there
RUN apk update && \
    apk add nginx sed && \
    apk add certbot dcron py2-future py2-certifi py2-urllib3 py2-chardet && \
    mkdir /run/nginx

# configuration
COPY site.conf /etc/nginx/conf.d/
COPY patch-run.sh /usr/bin

# user sites
VOLUME /root
VOLUME /home

# nginx
EXPOSE 80

# ssl configuration -- only needed for SSL
EXPOSE 443
# copy dhparams
RUN mkdir -p /etc/ssl/certs/dhparam
COPY dhparam.pem /etc/ssl/certs/
# copy cert renew stuff
COPY cert-autorenew.sh /etc/periodic/weekly/

STOPSIGNAL SIGTERM

CMD ["patch-run.sh"]
