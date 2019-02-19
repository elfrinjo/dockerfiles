FROM alpine:edge

LABEL maintainer "J. Elfring <devops@elfrinjo.de>"

## Install Packages
RUN apk add --no-cache \
			--update \
			ca-certificates \
            libcrypto1.1 \
			libidn \
			lua5.2 \
			lua5.2-expat \
			lua5.2-filesystem \
			lua5.2-sec \
			lua5.2-socket \
			openssl

## Install build envirnoment, build and remove unneeded things
## This is done in one step to reduce image size
RUN set -x \
	##
	## Build Environment
	&& apk add --update \
               --no-cache \
               --virtual .build-deps \
               alpine-sdk \
               libidn-dev \
               linux-headers \
               lua5.2-busted \
               lua5.2-dev \
               openssl-dev \
	&& ln -s /usr/bin/busted-5.2 /usr/local/bin/busted \
	##
	## Prosody
	&& curl --silent --output /prosody-trunk.tar.gz "https://hg.prosody.im/trunk/archive/0.11.tar.gz" \
	&& mkdir /prosody-src \
	&& cd /prosody-src \
	&& tar xzf /prosody-trunk.tar.gz --strip 1 \
    && ./configure --no-example-certs \
                   --cflags='-fPIC -Wall -std=c99 -pedantic -DWITHOUT_MALLINFO' \
    && make \
    && make test \
    && make install \
    && cd / \
	##
	## Prosody Community Modules
    && curl --silent --output /prosody-modules.tar.gz "https://hg.prosody.im/prosody-modules/archive/default.tar.gz" \
    && mkdir /usr/local/lib/prosody-community-modules \
	&& cd /usr/local/lib/prosody-community-modules \
	&& tar xzf /prosody-modules.tar.gz --strip 1 \
	&& cd mod_admin_web/admin_web \
	&& ./get_deps.sh \
	##
	## Cleanup
    && rm -rf /prosody-src \
    && rm -f /prosody-src.tar.gz \
    && rm -f /prosody-modules.tar.gz \
	&& rm -f /usr/local/bin/busted \
    && apk del .build-deps

COPY ./assets/prosody.cfg.lua /usr/local/etc/prosody/prosody.cfg.lua
RUN chown daemon:daemon /usr/local/var/lib/prosody

EXPOSE 5000 5222 5269 5347 5280 5281
VOLUME ["/usr/local/etc/prosody", "/usr/local/var/lib/prosody"]

USER daemon
ENTRYPOINT ["/usr/local/bin/prosody"]

