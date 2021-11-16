if !exists('g:vscode')
	source $HOME/.config/nvim/core.vim
	source $HOME/.config/nvim/functions.vim
	source $HOME/.config/nvim/plugins.vim
	source $HOME/.config/nvim/theme.vim
	source $HOME/.config/nvim/fzf.vim
	source $HOME/.config/nvim/airline.vim

	source $HOME/.config/nvim/coding/core.vim
	" source $HOME/.config/nvim/coding/linting.vim
	" source $HOME/.config/nvim/coding/coc.vim
	source $HOME/.config/nvim/coding/golang.vim
	source $HOME/.config/nvim/coding/python.vim
	source $HOME/.config/nvim/coding/yaml.vim
	source $HOME/.config/nvim/coding/git.vim
	source $HOME/.config/nvim/coding/text.vim

  lua require('coding')
  source $HOME/.config/nvim/coding/lsp-stuff.vim
endif
