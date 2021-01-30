FROM alpine:3.12
LABEL maintainer "J. Elfring <devops@elfrinjo.de>"

## Install prereqs
RUN apk add --update --no-cache \
        curl \
        git \
        mc \
        apache2 \
        apr-util-dbm_db \
        apache2-webdav \
	## We don't need the default webdav config
	&& rm -f /etc/apache2/conf.d/dav.conf \
	## We will not be root, so we need to be able to access our pid file
	&& chown apache:apache /run/apache2 \
	## Apache should have full-access to it's docroot
    && chown -R apache:apache /var/www/localhost \
	## Prepare lock-db
	&& touch /var/www/dav.lockdb \
    && chown -R apache:apache /var/www/dav.lockdb

## Configure apache
COPY assets/httpd.conf /etc/apache2/httpd.conf

USER apache

VOLUME /var/www
WORKDIR /var/www
EXPOSE 8080
ENV SERVERADMINMAIL=webmaster@example.com
CMD httpd -D FOREGROUND





