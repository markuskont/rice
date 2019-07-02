#!/bin/bash
# Aurorice
# Work in progress, missing dependencies etc

WALLPAPER="https://w.wallhaven.cc/full/13/wallhaven-13x79v.jpg"

DM=false
ENV_SETUP=false
CODE=true
GUI=true
RDP=false


if $GUI; then
  read -p "Set up display manager? (y/n)?" choice
  case "$choice" in 
    y|Y ) DM=true;;
    n|N ) DM=false;;
    * ) echo "invalid choice"; exit 1;;
  esac
  
  read -p "Set up xRDP? (y/n)?" choice
  case "$choice" in 
    y|Y ) RDP=true;;
    n|N ) RDP=false;;
    * ) echo "invalid choice"; exit 1;;
  esac
fi

read -p "Install environment and config files? Will overwrite any existing profile and ~/.config files!!! (y/n)?" choice
case "$choice" in 
  y|Y ) ENV_SETUP=true;;
  n|N ) ENV_SETUP=false;;
  * ) echo "invalid choice"; exit 1;;
esac

source ./.profile

echo "Installing deps"
if [ -f "/etc/arch-release" ]; then
  pkgs="neovim tmux zsh yarn make htop"
  # TODO - headless vs gui setup
  if $GUI; then
    pkgs+=" base-devel cmake dmenu sxhkd compton dunst rofi feh ranger qutebrowser firefox-developer-edition extra/ttf-hack xorg-server xorg-xinit"
  fi
  if $DM; then 
    pkgs+=" lightdm" 
  fi
  if $CODE; then 
    pkgs+=" go nodejs npm python python-pip" 
  fi
  echo $pkgs
  sudo pacman --needed --noconfirm -Syyu $pkgs
fi

echo "Setting up zsh"
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
  make build || exit 1
  make install-tools
  if $CODE; then
    cd rust-dwm-status/ && cargo install --path ./ --force ; cd ..
  fi
  curl -fLo ~/.config/wall.pic $WALLPAPER
  if $RDP; then
    git clone https://aur.archlinux.org/xrdp.git /tmp/xrdp ; cd /tmp/xrdp ; makepkg -si
    git clone https://aur.archlinux.org/xorgxrdp-git.git /tmp/xorgxrdp ; cd /tmp/xorgxrdp ; makepkg -si
    sudo echo "allowed_users=anybody" > /etc/X11/Xwrapper.config
    sudo systemctl enable xrdp.service
    sudo systemctl enable xrdp-sesman.service
  fi
fi

if $DM; then 
  echo "Setting up lightdm"
  git clone https://aur.archlinux.org/lightdm-mini-greeter.git /tmp/mini-greeter ; cd /tmp/mini-greeter ; makepkg -si
  cd -
  sudo make install-dwm-ldm
  sudo sed -i "s,USER,$(whoami),g" /etc/lightdm/lightdm-mini-greeter.conf
  sudo systemctl enable lightdm.service
fi

echo "Configuring neovim"
python -m pip install --user --upgrade neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qa
if $CODE; then
  nvim +GoInstallBinaries +qa
  for addon in rls tsserver python snippets ; do
    nvim "+CocInstall coc-${addon}" +qa
  done
fi
