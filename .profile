export PATH="$HOME/.local/bin:$PATH"
export TERMINAL=st
export BROWSER=qutebrowser
export EDITOR=nvim
export LIBVIRT_DEFAULT_URI="qemu:///system"

export PATH="$HOME/.cargo/bin:$PATH"

export GOPATH="$HOME/Projects/go"
export PATH="$PATH:$GOPATH/bin"

export PATH=~/.npm-global/bin:$PATH
export DMENU_OPTS='-i -l 20 -fn "hack 9" -sb "#444444"'

alias l=exa
alias ll="exa -l"
alias lll="exa -lah"

alias grep=rg
alias ed=$EDITOR

alias fuckit='vagrant destroy -f && vagrant up'
alias zzz='systemctl suspend'

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
