# tiny webdav server

Builds an image to run a small webDav server.

HINT: This is not an official image. Builds might not happen regularly.

The only authentication mechanism is a token, containing the only accessible
directory on the server.

| ENV          | Default      | Description
|--------------|--------------|------------------------------------------------------------
| TOKEN        | s3cret       | Name of the only accessible directory

It is based on Alpine Linux http://alpinelinux.org/.

## Usage

For example this way:

```console
$ docker run -d \
         -e TOKEN="SuperS3cret" \
         -v /etc/localtime:/etc/localtime:ro \
         -p 80:80 \
         --restart=always \
         elfrinjo/tinywebdav
```
