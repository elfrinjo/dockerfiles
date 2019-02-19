FROM alpine:3.8
LABEL maintainer "J. Elfring <devops@elfrinjo.de>"

RUN apk --update --no-cache add tor

COPY ./assets/torrc.relay /etc/tor/torrc.relay
COPY ./assets/entrypoint.sh /etc/tor/entrypoint.sh

RUN chown -R tor /etc/tor \
    && chmod 755 /etc/tor/entrypoint.sh \
	&& mkdir /var/run/tor \
	&& chown tor /var/run/tor

ENV TOR_NICK="Landesverrat" \
    TOR_CONTACT="Not Provided" \
    TOR_BRIDGE=0

VOLUME /var/lib/tor

# tor port as defined in torrc
EXPOSE 9001 9030

USER tor
ENTRYPOINT [ "/etc/tor/entrypoint.sh" ]
