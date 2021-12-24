call plug#begin('~/.local/share/nvim/plug')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'https://github.com/dracula/vim.git', { 'dir': '~/.local/share/nvim/plug/dracula-theme' }
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
Plug 'frankier/neovim-colors-solarized-truecolor-only'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Go specific plugins
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"
" dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
" nvim-go
Plug 'crispgm/nvim-go'

Plug 'vim-airline/vim-airline'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-commentary'

Plug 'Vimjas/vim-python-pep8-indent'
Plug 'chrisbra/csv.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'hrsh7th/cmp-nvim-lsp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'folke/which-key.nvim'
call plug#end()
