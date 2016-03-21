FROM chambana/uwsgi-php:latest

MAINTAINER Josh King <jking@chambana.net>

RUN echo "dokuwiki dokuwiki/wiki/password password dokuwiki" > preseed.txt
RUN echo "dokuwiki dokuwiki/wiki/confirm password dokuwiki" >> preseed.txt
RUN echo "dokuwiki dokuwiki/system/documentroot string /" >> preseed.txt
RUN echo "dokuwiki dokuwiki/system/writeconf boolean true" >> preseed.txt
RUN echo "dokuwiki dokuwiki/system/writeplugins boolean true" >> preseed.txt
RUN debconf-set-selections preseed.txt

RUN apt-get -qq update && \
	apt-get install -y --no-install-recommends php-cgi php-apcu dokuwiki/testing && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN rm preseed.txt

ADD dokuwiki.conf /etc/uwsgi/apps-available/dokuwiki.conf

EXPOSE 80

VOLUME ["/var/lib/dokuwiki", "/etc/dokuwiki"]

USER www-data

CMD ["uwsgi --ini /etc/uwsgi/apps-available/dokuwiki.conf"]
