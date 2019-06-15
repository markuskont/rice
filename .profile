[[ -f ~/.env-work ]] && source ~/.env-work
[[ -f ~/.env-golang ]] && source ~/.env-golang
[[ -f ~/.cargo/env ]] && source ~/.cargo/env
export PATH="$HOME/.cargo/bin:$PATH"
export TERMINAL=st
export BROWSER=qutebrowser

export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
export VIRSH_DEFAULT_CONNECT_URI="qemu:///system"
export EDITOR="nvim"
