install-env:
	cp .gtkrc-2.0 .xinitrc .tmux.conf .zshrc .Xresources .xprofile .profile .zprofile ~/
install-configs:
	rsync -va ./.config/ ~/.config/
	cp ./.tmux.conf ~/.tmux.conf
install-user-conf:
	$(MAKE) install-env
	$(MAKE) install-configs
install-system-conf:
	$(MAKE) install-dwm-ldm
