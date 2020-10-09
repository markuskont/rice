call plug#begin('~/.local/share/nvim/plug')
" Cannot live without
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
"Plug 'lotabout/skim.vim'
" Color schemes
Plug 'https://github.com/dracula/vim.git', { 'dir': '~/.local/share/nvim/plug/dracula-theme' }
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
Plug 'herrbischoff/cobalt2.vim'
Plug 'frankier/neovim-colors-solarized-truecolor-only'

Plug 'tpope/vim-fugitive'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Coding helpers
" Core stuff
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
Plug 'honza/vim-snippets'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'liuchengxu/vista.vim'

" Python
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'Vimjas/vim-python-pep8-indent'
" Rust
Plug 'rust-lang/rust.vim'
" R
Plug 'jalvesaq/Nvim-R'
" CSV
Plug 'chrisbra/csv.vim'
" Ansible
Plug 'pearofducks/ansible-vim'
Plug 'szymonmaszke/vimpyter'
call plug#end()
