call plug#begin('~/.local/share/nvim/plug')
" Cannot live without
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
"Plug 'lotabout/skim.vim'
" Color schemes
Plug 'https://github.com/dracula/vim.git', { 'dir': '~/.local/share/nvim/plug/dracula-theme' }
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
" Plug 'herrbischoff/cobalt2.vim'
Plug 'frankier/neovim-colors-solarized-truecolor-only'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Coding helpers
" Core stuff
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
" Plug 'honza/vim-snippets'
Plug 'AndrewRadev/splitjoin.vim'
" Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
" Plug 'liuchengxu/vista.vim'

" Python
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" Plug 'Vimjas/vim-python-pep8-indent'
" CSV
Plug 'chrisbra/csv.vim'

" LSP
Plug 'neovim/nvim-lspconfig'

" Extentions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'

" Autocompletion framework
Plug 'hrsh7th/nvim-cmp'
" cmp LSP completion
Plug 'hrsh7th/cmp-nvim-lsp'
" cmp Snippet completion
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
Plug 'golang/vscode-go'

" cmp Path completion
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

Plug 'mfussenegger/nvim-lint'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Plug 'szymonmaszke/vimpyter'
call plug#end()
