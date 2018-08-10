# Created by newuser for 5.4.2

autoload -U colors && colors
alias ls='ls --color=auto'

# set custom env
export PATH="$PATH:$HOME/bin"
export VIRSH_DEFAULT_CONNECT_URI="qemu:///system"
export EDITOR="vim"

# history stuff
#setopt inc_append_history
#setopt share_history
#export SAVEHIST=1500
export KEYTIMEOUT=1

#set history size
export HISTSIZE=10000
#save history after logout
export SAVEHIST=10000
#history file
export HISTFILE=~/.zsh_history
#append into history file
setopt INC_APPEND_HISTORY
#save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS
#add timestamp for each entry
setopt EXTENDED_HISTORY   

alias fuckit='vagrant destroy -f && vagrant up'
alias zzz='systemctl suspend'

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

export WALLPAPER="~/Pictures/wallhaven-535721.jpg"

[[ -f ~/.env-work ]] && source ~/.env-work

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

_current_envrc=""

## Per-project enviornment variables
#_envrc_handler() {
#	local current_dir="$(pwd -P)"
#
#	while [[ $current_dir != "" ]]; do
#		if [[ -e "$current_dir/.envrc" ]]; then
#			_load_envrc "$current_dir/.envrc"
#			return
#		fi
#		current_dir=${current_dir%/*}
#	done
#
#	# If we found no envrc and we were using one before, restore the previous
#	# enviornment
#	if [[ "$_current_envrc" != "" ]]; then
#		_unload_current_envrc
#	fi
#}
#
#_load_envrc() {
#	# Don't do anything if we're already using this envrc
#	[[ $_current_envrc == $1 ]] && return
#
#	# If we're using another envrc, unload it first
#	[[ $_current_envrc != '' ]] && [[ $_current_envrc != $1 ]] && _unload_current_envrc
#
#	# Generate a script to reset the changed variables once we've left the
#	# directory
#	while read l; do
#		local current_var=$(echo $l | grep -oP '^[^\s=]*')
#
#		if eval "[[ -z $(echo '$'$current_var) ]]"; then
#			_envrc_diff="${_envrc_diff}unset $current_var;"
#		else
#			_envrc_diff="${_envrc_diff}export $current_var='$(eval "echo -n \$$current_var")';"
#		fi
#
#		# Now execute the line from envrc
#		eval "export $l"
#	done < "$1"
#	
#	_current_envrc=$1
#	echo "(zsh: Loaded envrc: '$1')"
#}
#
#_unload_current_envrc() {
#	eval "$_envrc_diff"
#	unset _envrc_diff
#	echo "(zsh: Unloaded '$_current_envrc')"
#	_current_envrc=""
#}
