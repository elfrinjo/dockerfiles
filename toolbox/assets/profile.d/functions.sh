#!/bin/bash

# Trap RC != 0 and display
EC() {
	echo -e '\e[1;31m'code $?'\e[m\n'
}
trap EC ERR

# Create a new directory and enter it
mkd() {
	mkdir -p "$@" && cd "$@"
}

# Make a temporary directory and enter it
tmpd() {
	if [ $# -eq 0 ]; then
		dir=`mktemp -d` && cd $dir
	else
		dir=`mktemp -d -t $1.XXXXXXXXXX` && cd $dir
	fi
}

# Run `dig` and display the most useful info
digga() {
	dig +nocmd "$1" any +multiline +noall +answer
}

## Dump SSL Cert from host
## sslcheck example.com:25 -starttls smtp
## sslcheck example.com:443
sslcheck(){
	echo -n | openssl s_client -connect $* | tee /dev/tty | openssl x509 -text -noout
}

## SSH agent
## Add sth like test -z $noKeychain && agent to ~/.extra
function agent(){
	/usr/bin/keychain --nolock --nogui $HOME/.ssh/id_rsa
	source $HOME/.keychain/$HOSTNAME-sh
}



## Kubernetes Goodies
k(){
	kubectl $*
}

k-sel(){
	kubeconfig=$(find ~/.kube/kubesel -type f | rev | cut -d "/" -f 1 | rev | sort | fzf --height=25%)
	export KUBECONFIG=~/.kube/kubesel/$kubeconfig
	echo
	kubectl config get-contexts
}

k-ns(){
	kubectl config set-context
	        --current \
		    --namespace=$(kubectl get namespace | grep Active \
			                                    | cut -d " " -f1 \
												| fzf --height=25%
						 )
	echo
	kubectl config get-contexts
}
