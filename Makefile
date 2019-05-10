install :
	rsync -va ./.config/ ~/.config/
	cp ./.tmux.conf ~/.tmux.conf
	cp ./.zshrc ~/.zshrc
	cp ./.Xresources ~/.Xresources
