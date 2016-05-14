# docker-dokuwiki
A container for running a Dokuwiki instance on uwsgi-php, behind a proxy. It exposes port 80 by default. If you wish your wiki data to persist, it is recommended to mount persistent volumes to `/var/lib/dokuwiki` and `/etc/dokuwiki` inside the container.
