#!/bin/bash
# autorice
# Work in progress, missing dependencies etc

# Script options
CURL_OTPS="--retry 5 --retry-delay 2 --retry-max-time 60"
AUR_OPTS="--noconfirm"

WALLPAPER="https://w.wallhaven.cc/full/r2/wallhaven-r2opq1.jpg"

DM=false
ENV_SETUP=true
CODE=true
GUI=false
RDP=false
HYPERV=false

SESSIONS=( "dwm" "openbox-session" )
WM=""

function install_zsh() {
  echo "Setting up shell"

  mv $HOME/.oh-my-zsh $HOME/.oh-my-zsh.bak

  sh -c "$(curl ${CURL_OTPS} -fsSL  https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"

  git clone https://github.com/zsh-users/zsh-completions      ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
  git clone https://github.com/zsh-users/zsh-autosuggestions  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

  sudo usermod -s "/bin/zsh" $(whoami)
}

function check_wsl() {
  if grep -q Microsoft /proc/version; then
    WSL=true
  else
    WSL=false
  fi
}

read -p "GUI system? (y/n)?" choice
case "$choice" in 
  y|Y ) GUI=true;;
  n|N ) GUI=false;;
  * ) echo "invalid choice"; exit 1;;
esac

if $GUI; then
  read -p "Select window manager - 1. dwm 2. openbox " choice
  case "$choice" in 
    1 ) WM=${SESSIONS[0]} ;;
    2 ) WM=${SESSIONS[1]} ;;
    * ) echo "invalid choice"; exit 1;;
  esac

  read -p "Set up display manager? (y/n)?" choice
  case "$choice" in 
    y|Y ) DM=true;;
    n|N ) DM=false;;
    * ) echo "invalid choice"; exit 1;;
  esac
  
  read -p "Set up xRDP? (y/n)?" choice
  case "$choice" in 
    y|Y ) 
      RDP=true
      read -p "Hyper-v enhanced session? (y/n)" choice
      case "$choice" in
        y|Y ) HYPERV=true;;
        n|N ) HYPERV=false;;
      esac
      ;;
    n|N ) RDP=false ;;
    * ) echo "invalid choice"; exit 1;;
  esac
fi

git submodule update --init --recursive

echo "Installing base software"
pkgs="neovim tmux zsh yarn make htop"
pkgs+=" base-devel cmake"
if $HYPERV; then
  pkgs+=" xf86-video-fbdev"
fi
if $GUI; then
  pkgs+=" dmenu sxhkd compton dunst rofi feh ranger"
  pkgs+=" xorg-server xorg-xinit"
  pkgs+=" qutebrowser firefox-developer-edition"
  pkgs+=" extra/ttf-hack numix-gtk-theme qt5-styleplugins"
  case $WM in
    ${SESSIONS[0]} )
      pkgs+=" finch"
      ;;
    ${SESSIONS[1]} )
      pkgs+=" openbox"
      pkgs+=" pidgin"
      ;;
  esac
fi
if $DM; then 
  pkgs+=" lightdm" 
fi
if $CODE; then 
  pkgs+=" go"
  pkgs+=" nodejs npm"
  pkgs+=" python python-pip" 
fi
echo $pkgs
sudo pacman --needed --noconfirm -Syyu $pkgs


echo "Setting up shell"
install_zsh

source ./.profile
if $ENV_SETUP; then
  make install-user-conf
  sed -i "s,REPLACE,${WM},g" $HOME/.xinitrc
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
  curl $CURL_OTPS --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s - -y
  command -v rg || cargo install --force ripgrep
  command -v exa || cargo install --force exa
  rustup component add rls rust-analysis rust-src
fi

if $GUI; then
  case $WM in
    ${SESSIONS[1]} )
      echo "Installin polybar from aur"
      git clone https://aur.archlinux.org/polybar.git /tmp/polybar ; cd /tmp/polybar ; makepkg -si $AUR_OPTS ; cd -
      ;;
  esac

  echo "Building DWM and ST"
  make build || exit 1
  make install-tools

  sed -i "s,MYPATH,$PATH,g" ~/.config/systemd/user/sxhkd.service
  systemctl --user daemon-reload

  if $CODE; then
    cd rust-dwm-status/ && cargo install --path ./ --force ; cd ..
  fi
  curl $CURL_OTPS -fLo ~/.config/wall.pic $WALLPAPER
  if $RDP; then
    if $HYPERV; then
      git clone https://github.com/Microsoft/linux-vm-tools.git /tmp/linux-vm-tools
      cd /tmp/linux-vm-tools/arch
      makepkg -si $AUR_OPTS
      sudo $(pwd)/install.sh
      cd -
    else
      git clone https://aur.archlinux.org/xrdp.git /tmp/xrdp ; cd /tmp/xrdp ; makepkg -si $AUR_OPTS
      git clone https://aur.archlinux.org/xorgxrdp-git.git /tmp/xorgxrdp ; cd /tmp/xorgxrdp ; makepkg -si $AUR_OPTS
      sudo bash -c "echo \"allowed_users=anybody\" > /etc/X11/Xwrapper.config"
      sudo systemctl enable xrdp.service
      sudo systemctl enable xrdp-sesman.service
      cd -
    fi
  fi
fi

if $DM; then 
  echo "Setting up lightdm"
  git clone https://aur.archlinux.org/lightdm-mini-greeter.git /tmp/mini-greeter ; cd /tmp/mini-greeter ; makepkg -si $AUR_OPTS
  cd -
  sudo make install-dwm-ldm
  sudo sed -i "s,USER,$(whoami),g"  /etc/lightdm/lightdm-mini-greeter.conf
  sudo sed -i "s,SESS,${WM},g"      /etc/lightdm/lightdm.conf
  sudo systemctl enable lightdm.service
fi

echo "Configuring neovim"
python -m pip install --user --upgrade neovim
curl $CURL_OTPS -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qa
if $CODE; then
  nvim +GoInstallBinaries +qa
#  for addon in rls tsserver python snippets ; do
#    nvim "+CocInstall coc-${addon}" +qa
#  done
fi
