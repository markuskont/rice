if !exists('g:vscode')
  lua require('options')
  lua require('keybindings')

	source $HOME/.config/nvim/core.vim
	source $HOME/.config/nvim/functions.vim
	source $HOME/.config/nvim/plugins.vim
	source $HOME/.config/nvim/theme.vim
	source $HOME/.config/nvim/airline.vim
	source $HOME/.config/nvim/fzf.vim

	source $HOME/.config/nvim/coding/python.vim
	source $HOME/.config/nvim/coding/yaml.vim
	source $HOME/.config/nvim/coding/text.vim

  lua require('finder')
  lua require('explorer')
  lua require('git')
  lua require('terminal')
  lua require('projectmanager')
  lua require('treesitter')
  lua require('coding')
  lua require('complete')
  lua require('golang')
  lua require('linting')
  lua require('pairs')
  lua require('whichkey')
  lua require('autocommands')
endif
