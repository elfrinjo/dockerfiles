# torrelay docker image

Builds an image to run tor as a relay.

HINT: This is not an official image. Builds might not happen regularly.

A simple config to run as bridge or middle relay is included. This config takes
environmet parameters:

| ENV             | Default      | Description
|-----------------|--------------|------------------------------------------------------------
| TOR_NICK        | Landesverrat | the Nickname (String)
| TOR_CONTACT     | Not Provided | ContactInfo (String)
| TOR_BRIDGE      | 0            | run as a bridge (0,1)
| TOR_OPTION{1-9} | NIL          | arbitrary option to be added at the end of config (String)

It is based on Alpine Linux http://alpinelinux.org/.

## Usage

For example this way:

```console
$ docker run -d \
         -e TOR_OPTION1="RelayBandwidthRate 2MBytes" \
         -e TOR_OPTION2="RelayBandwidthBurst 5MBytes" \
         -e TOR_OPTION3="AccountingMax 30GB" \
         -e TOR_OPTION4="AccountingStart day 00:00" \
         -p 9001:9001 \
         -p 9030:9030 \
         --restart=always \
         -v /etc/localtime:/etc/localtime:ro \
         -v torrelay:/var/lib/tor \
         elfrinjo/torrelay
```
