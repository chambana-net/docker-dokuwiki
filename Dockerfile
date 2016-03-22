FROM chambana/uwsgi-php:latest

MAINTAINER Josh King <jking@chambana.net>

RUN echo "dokuwiki dokuwiki/wiki/password password dokuwiki" | debconf-set-selections && \
	echo "dokuwiki dokuwiki/wiki/confirm password dokuwiki" | debconf-set-selections && \
	echo "dokuwiki dokuwiki/system/documentroot string /" | debconf-set-selections && \
	echo "dokuwiki dokuwiki/system/writeconf boolean true" | debconf-set-selections && \
	echo "dokuwiki dokuwiki/system/writeplugins boolean true" | debconf-set-selections

RUN apt-get -qq update && \
	apt-get install -y --no-install-recommends php5-cgi php5-apcu dokuwiki/testing && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

ADD dokuwiki.conf /etc/uwsgi/apps-available/dokuwiki.conf

EXPOSE 80

VOLUME ["/var/lib/dokuwiki", "/etc/dokuwiki"]

CMD ["uwsgi", "--uid", "www-data", "--gid", "www-data", "--ini", "/etc/uwsgi/apps-available/dokuwiki.conf"]
