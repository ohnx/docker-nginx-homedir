# nginx-homedir

docker + alpine linux + nginx, but nginx is configured to serve files in /home/.../public_html as /~.../

Typical of servers that host web data for lots of users.

Recommended usage is to create a volume (i.e. `docker volume create --name webserver_users`)
and mount that at `/home` on this container, as well as a container with some sort of file host (e.g. sFTP, FTP).

To use, specify an environment variable of SERVER_NAME to be whatever the desired server name is. e.g. `example.com`

The master branch also builds in SSL support, with autorenewing certificates, using `certbot`. `certbot` needs python, which increases
the image size to almost 100MB. If SSL is not needed, there is another branch `no-ssl` where SSL is disabled.
