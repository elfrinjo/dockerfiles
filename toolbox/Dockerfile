FROM alpine:latest
LABEL maintainer "J. Elfring <code@elfring.ms>"

RUN apk add --update --no-cache \
            bash \
            bind-tools \
			busybox-extras \
			ca-certificates \
            curl \
            git \
            jq \
			msmtp \
			mysql-client \
			netcat-openbsd \
			openssh-client \
			openssl \
			postgresql-client \
			rsync \
			socat \
			sqlite \
			vim \
			w3m \
			wget

RUN apk add --update --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
            helm \
			kubectl

ADD assets/profile.d/* /etc/profile.d/
COPY assets/vimrc /etc/vim/vimrc

WORKDIR /root

CMD /bin/bash -li





