FROM archlinux/base:latest
LABEL maintainer "J. Elfring <devops@elfrinjo.de>"

## Set faster mirrors
COPY assets/mirrorlist /etc/pacman.d/mirrorlist

## Install prereqs and create a user with
## administrative privileges to install packages
RUN pacman --sync --refresh --needed --noconfirm \
		base-devel \
		git \
		go \
	&& useradd --create-home user
COPY assets/sudoers /etc/sudoers

## Switch to the new user and install yay from aur
USER user
RUN cd /home/user \
	&& git clone https://aur.archlinux.org/yay.git \
	&& cd yay \
	&& makepkg --syncdeps --install --noconfirm \
	&& cd /home/user \
	&& rm -rf yay

## Install profanity-git from aur
RUN cd /home/user \
	&& yay --sync --noconfirm profanity-git

## Cleanup
RUN sudo pacman --noconfirm -Rcns go yay texinfo \
	&& sudo pacman --noconfirm -Rsn $(pacman -Qqdt)

WORKDIR /home/user
CMD ["/usr/sbin/profanity"]
