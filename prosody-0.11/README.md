# Prosody Docker image

Create an image for running prosody XMPP server version 0.11
http://prosody.im/ on Alpine Linux.

HINT: This is not an official image. Builds might not happen regularly.

You will need to configure a vhost inside the config volume (prosody.cfg.lua).

The certificate generation with prosodyctl does not work.
However, certificates can be put into the config volume or be linked in from an
other volume (like letsencrypt). I suggest acme.sh for communication with
Letsencrypt. https://github.com/Neilpang/acme.sh/wiki/Run-acme.sh-in-docker
You need to configure the certificates location inside prosodys config.

IPORTANT: You really should add TLS.

## Usage

Start the container with volumes for config, database and maybe additional
certificates.
Do not forget to customize your configuration!
```console
$ docker run -d \
    -p 5000:5000 \
    -p 5222:5222 \
    -p 5269:5269 \
    -p 5280:5280 \
    -p 5281:5281 \
    --restart always \
    --name prosody \
    -v /etc/localtime:/etc/localtime:ro \
    -v prosody-cfg:/usr/local/etc/prosody:ro \
    -v prosody-data:/usr/local/var/lib/prosody \
    elfrinjo/prosody
```

To create the first user, exec into the running container and use prosodyctl.
```console
$ docker exec -ti prosody bash
/ $ prosodyctl adduser JID
```

To Create a certificate for you host:
```console
$ docker pull neilpang/acme.sh
$ docker run --rm  -it \
    --volume prosody-acme:/acme.sh \
    --net=host \
    neilpang/acme.sh --issue  \
                      -d example.com \
                      -d conference.example.com \
                     --standalone
```

To renew the certificate:
```console
$ docker pull neilpang/acme.sh
$ docker run --rm  -it \
    --volume prosody-acme:/acme.sh \
    --net=host \
    neilpang/acme.sh --cron --standalone
$ docker run --rm \
    -v prosody-acme:/acme.sh \
    -v prosody-cfg:/target \
    neilpang/acme.sh --install-cert \
                      -d example.com \
                     --key-file /target/certs/example.com/example.com.key \
                     --fullchain-file /target/certs/example.com/fullchain.cer
```
