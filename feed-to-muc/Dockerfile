FROM golang:latest AS build-env

RUN go get salsa.debian.org/mdosch-guest/feed-to-muc
RUN go install salsa.debian.org/mdosch-guest/feed-to-muc



FROM alpine:latest

RUN apk --no-cache add ca-certificates \
	&& mkdir -p /.config/feed-to-muc \
	&& mkdir /.cache \
	&& chown nobody:nobody /.cache \
	&& mkdir /lib64 \
	&& ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY --from=build-env /go/bin/feed-to-muc /

USER nobody

CMD ["/feed-to-muc"]

