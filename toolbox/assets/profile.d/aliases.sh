#!/bin/bash

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# Shortcuts
alias g="git"
alias h="history"
alias k="kubectl"

# Always use color output for `ls`
# And sort directories before files
alias ls="ls --color --group-directories-first"

# ls abbreviation
alias l="ls -l"
alias ll="ls -l"
alias la="ls -la"

# Always enable colored `grep` output
alias grep='grep --color=auto '

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Canonical hex dump some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# vi == vim
alias vi='vim'

# Passwort erstellen
alias mkpasswd='openssl rand -base64 40 | cut -c1-40'
