FROM archlinux/base:latest
LABEL maintainer "J. Elfring <devops@elfrinjo.de>"

## Set faster mirrors
COPY assets/mirrorlist /etc/pacman.d/mirrorlist

## Install prereqs and create a user with
## administrative privileges to install packages
RUN pacman --sync --refresh --needed --noconfirm \
		base-devel \
		git \
	&& useradd --create-home user
COPY assets/sudoers /etc/sudoers

## Switch to the new user and install yaourt from aur
USER user
RUN cd /tmp \
	## Install package-query, a prereq for yaourt
	&& curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz \
	&& tar -xvzf package-query.tar.gz \
	&& cd package-query \
	&& makepkg -si --noconfirm \
	&& cd /tmp \
	&& rm -rf package-query.tar.gz package-query \
	## Install yaourt
	&& curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz \
	&& tar -xvzf yaourt.tar.gz \
	&& cd yaourt \
	&& makepkg -si --noconfirm \
	&& cd /tmp \
	&& rm -rf yaourt.tar.gz yaourt \
	## Install profanity
    && cd /home/user \
	&& yaourt --sync --noconfirm profanity-git
	## Cleanup
RUN  sudo pacman --noconfirm -Rcns yaourt package-query git \
	&& pacman -Qgq base > /tmp/pkg_base \
	&& pacman -Qgq base-devel > /tmp/pkg_base-devel \
	&& grep -f /tmp/pkg_base -v /tmp/pkg_base-devel > /tmp/pkg_devel 
	#&& sudo pacman --noconfirm -Rsu base-devel \
 	#&& sudo pacman --noconfirm -Rsn $(pacman -Qqdt)

WORKDIR /home/user
CMD ["/usr/sbin/profanity"]
