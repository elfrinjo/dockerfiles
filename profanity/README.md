## Profanity XMPP Client
Docker image for running the profanity xmpp client based on Arch Linux.
Profanity is installed from aur/profanity-git.
OMEMO is available,

## Usage
```console
# sudo docker run -ti --rm \
    -v ~/.local/share/profanity:/home/user/.local/share/profanity \
    -v ~/.config/profanity/:/home/user/.config/profanity \
    elfrinjo/profanity:latest
```
