#!/bin/bash
# Aurorice
# Work in progress, missing dependencies etc

DM=false
read -p "Set up display manager? (y/n)?" choice
case "$choice" in 
  y|Y ) DM=true;;
  n|N ) DM=false;;
  * ) echo "invalid choice"; exit 1;;
esac
ENV_SETUP=false
read -p "Install environment and config files? Will overwrite any existing profile and ~/.config files!!! (y/n)?" choice
case "$choice" in 
  y|Y ) ENV_SETUP=true;;
  n|N ) ENV_SETUP=false;;
  * ) echo "invalid choice"; exit 1;;
esac
# make optional later
CODE=true
GUI=true

echo "Installing deps"
if [ -f "/etc/arch-release" ]; then
  pkgs="neovim tmux zsh yarn"
  # TODO - headless vs gui setup
  if $GUI; then
    pkgs+=" cmake dmenu sxhkd compton dunst extra/ttf-hack"
  fi
  if $DM; then 
    pkgs+=" lightdm" 
  fi
  if $CODE; then 
    pkgs+=" go nodejs npm python python-pip" 
  fi
  echo $pkgs
  sudo pacman --needed -Sy $pkgs
fi

echo "Setting up zsh"
source ./.profile
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

if $ENV_SETUP; then
  make install-env
  make install-configs
fi

echo "Configuring nodejs"
if $CODE; then
  mkdir ~/.npm-global
  npm config set prefix '~/.npm-global'
  npm install -g dockerfile-language-server-nodejs
  npm install -g markdownlint-cli
fi

echo "Configuring rust"
if $CODE; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  command -v rg || cargo install --force ripgrep
  command -v exa || cargo install --force exa
  rustup component add rls rust-analysis rust-src
fi

if $GUI; then
  echo "Building DWM and ST"
  git submodule update --init --recursive
  make build && make install-tools
fi

if $DM; then sudo make install-dwm-ldm ; fi

echo "Configuring neovim"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qa
if $CODE; then
  nvim +GoInstallBinaries +qa
  for addon in rls tsserver python snippets ; do
    nvim "+CocInstall coc-${addon}" +qa
  done
fi
