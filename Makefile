build:
	$(MAKE) -C st/
	$(MAKE) -C dwm/
install-tools:
	mkdir -p ~/.local/bin
	cp -f ./st/st ./dwm/dwm ~/.local/bin
install-env:
	cp .tmux.conf .zshrc .Xresources .xprofile .profile .zprofile ~/
install-configs:
	rsync -va ./.config/ ~/.config/
install-dwm-ldm:
	cp -f lightdm/dwm.desktop /usr/share/xsessions/
