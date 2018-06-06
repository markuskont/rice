# Created by newuser for 5.4.2

autoload -U colors && colors
alias ls='ls --color=auto'

# history stuff
setopt inc_append_history
setopt share_history
# set custom env
export PATH="$PATH:$HOME/go/bin:$HOME/bin"
export VIRSH_DEFAULT_CONNECT_URI="qemu:///system"
export EDITOR="vim"

export SAVEHIST=1500
export HISTFILE=~/.zsh_history

alias fuckit='vagrant destroy -f && vagrant up'
alias zzz='systemctl suspend'

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

export WALLPAPER="~/Pictures/wallhaven-535721.jpg"

source ~/.env-work

# functions
function est_keymap {
  setxkbmap ee
}

function lookingGlassPrep {
  sudo touch /dev/shm/looking-glass
  sudo chown markus:kvm /dev/shm/looking-glass
  sudo chmod 660 /dev/shm/looking-glass
}

bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}

# test
terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
function zle-line-init zle-keymap-select {
    PS1_2="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    PS1_3="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
    PS1="%{$terminfo_down_sc$PS1_2$terminfo[rc]%}$PS1_3"
    zle reset-prompt
}
preexec () { print -rn -- $terminfo[el]; }

zle -N zle-line-init
zle -N zle-keymap-select

export KEYTIMEOUT=1

