build:
	$(MAKE) -C st/
	$(MAKE) -C dwm/
install-tools:
	mkdir -p ~/.local/bin
	cp -f ./st/st ./dwm/dwm ~/.local/bin
	cp -f ./.local/bin/dwm-status.sh ~/.local/bin
install-env:
	cp .gtkrc-2.0 .xinitrc .tmux.conf .zshrc .Xresources .xprofile .profile .zprofile ~/
install-configs:
	rsync -va ./.config/ ~/.config/
install-dwm-ldm:
	mkdir -p /usr/share/xsessions
	cp -f lightdm/dwm.desktop /usr/share/xsessions/
	cp -f lightdm/lightdm.conf /etc/lightdm/
	cp -f lightdm/lightdm-mini-greeter.conf /etc/lightdm/
install-user-conf:
	$(MAKE) install-env
	$(MAKE) install-configs
install-system-conf:
	$(MAKE) install-dwm-ldm
