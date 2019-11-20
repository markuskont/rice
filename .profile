export PATH="$HOME/.local/bin:$PATH"
export TERMINAL=st
export BROWSER=firefox-developer-edition
export EDITOR=nvim
export LIBVIRT_DEFAULT_URI="qemu:///system"

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/.gem/ruby/2.6.0/bin/:$PATH"

export GOPATH="$HOME/Projects/go"
export PATH="$PATH:$GOPATH/bin"

export PATH=~/.npm-global/bin:$PATH
export DMENU_OPTS='-i -l 20 -fn "hack 9" -sb "#444444"'

alias l=exa
alias ll="exa -l"
alias lll="exa -lah"
alias lt="exa --tree"
alias llt="exa -lh --tree"
alias lllt="exa -alh --tree"

alias old_grep="/usr/bin/grep"
alias grep=rg
alias ed=$EDITOR

alias fuckit='vagrant destroy -f && vagrant up'
alias zzz='systemctl suspend'

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
