#!/bin/sh

## Startng cat to dump the accesslogpipe to stdout
cat <> /var/run/lighttpd/logpipe 1>&2 &
chown lighttpd:lighttpd /var/run/lighttpd/logpipe

## Create the "secret" directory
## And set in the config
mkdir /var/www/localhost/htdocs/$TOKEN
chown lighttpd:lighttpd /var/www/localhost/htdocs/$TOKEN
sed -i 's/xxTOKENxx/'"$TOKEN"'/g' /etc/lighttpd/lighttpd.conf

## Start lighttpd in foreground mode
/usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf 2>&1

sleep 10
