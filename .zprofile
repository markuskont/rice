export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export TERMINAL=st
export BROWSER=qutebrowser
export EDITOR=nvim
export LIBVIRT_DEFAULT_URI="qemu:///system"

alias l=exa
alias ll="exa -l"
alias lll="exa -lah"

alias grep=rg

alias fuckit='vagrant destroy -f && vagrant up'
alias zzz='systemctl suspend'

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

alias ed=$EDITOR
