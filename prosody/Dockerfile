FROM alpine:3.8

LABEL maintainer "J. Elfring <devops@elfrinjo.de>"

## Install Packages
RUN apk add --no-cache \
			--update \
            libcrypto1.0 \
			libidn \
			lua5.2 \
			lua5.2-expat \
			lua5.2-filesystem \
			lua5.2-sec \
			lua5.2-socket

## Install build envirnoment, build and remove unneeded things
## This is done in one step to reduce image size
RUN apk add --update \
            --no-cache \
            --virtual .build-deps \
            alpine-sdk \
            mercurial \
			libidn-dev \
            linux-headers \
            lua5.2-busted \
            lua5.2-dev \
            openssl-dev \
    && set -x \
	&& ln -s /usr/bin/busted-5.2 /usr/local/bin/busted \
    && hg clone https://hg.prosody.im/0.11 /prosody-src \
    && cd /prosody-src \
    && ./configure --no-example-certs \
        --cflags='-fPIC -Wall -std=c99 -pedantic -DWITHOUT_MALLINFO' \
    && make \
    && make test \
    && make install \
    && cd / \
    && rm -rf /prosody-src \
    && hg clone https://hg.prosody.im/prosody-modules/ /usr/local/lib/prosody-community-modules \
    && rm -rf /usr/local/lib/prosody-community-modules/.hg \
    && rm -rf /usr/local/lib/prosody-community-modules/.hgtags \
	&& rm -f /usr/local/bin/busted \
    && apk del .build-deps

COPY ./assets/prosody.cfg.lua /usr/local/etc/prosody/prosody.cfg.lua
RUN chown daemon:daemon /usr/local/var/lib/prosody

EXPOSE 5000 5222 5269 5347 5280 5281
VOLUME ["/usr/local/etc/prosody", "/usr/local/var/lib/prosody"]

USER daemon
ENTRYPOINT ["/usr/local/bin/prosody"]

