if !exists('g:vscode')
  lua require('options')
  lua require('keybindings')
  lua require('nvim-tree')

	source $HOME/.config/nvim/core.vim
	source $HOME/.config/nvim/functions.vim
	source $HOME/.config/nvim/plugins.vim
	source $HOME/.config/nvim/theme.vim

	source $HOME/.config/nvim/telescope.vim
	source $HOME/.config/nvim/airline.vim

	source $HOME/.config/nvim/coding/golang.vim
	source $HOME/.config/nvim/coding/python.vim
	source $HOME/.config/nvim/coding/yaml.vim
	source $HOME/.config/nvim/coding/git.vim
	source $HOME/.config/nvim/coding/text.vim

  lua require('coding')
  lua require('treesitter')

  source $HOME/.config/nvim/coding/lsp-stuff.vim
endif
