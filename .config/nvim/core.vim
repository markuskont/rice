" play nice with tiling window manager splits
autocmd VimResized * wincmd =

" Wrap words in quickfix window
augroup quickfix
  autocmd!
  autocmd FileType qf setlocal wrap
augroup END

" Use system clipboard
set clipboard=unnamedplus

" Some vim bindings were made with english keyboard layout in mind
" Jump paragraph is really awkward with Estonian keyboard (AltGr+7,AlgGr+0)
map ü {(
map õ })

tnoremap <F12> <C-\><C-n> 
map <F12> :call TermEnter()<CR>

" tabs v spaces
set tabstop=2       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=2    " Indents will have a width of 4
set softtabstop=2   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces

" Relative line numbers, oh dear lord yes
set relativenumber
set nu

" paste mode on/off
set pastetoggle=<F2>
" make it more snappy
set timeoutlen=1000 ttimeoutlen=0

" visuzlize special chars
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" Remap leader key to something more convenient
let mapleader=","

noremap <Leader>Y "*y
noremap <Leader>P "*p
noremap <Leader>y "+y
noremap <Leader>p "+p

" Resizing vim split height
set winheight=30
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>

" Consistent splitting
set splitbelow
set splitright

" Core leader mappings
" Close quickfix windows easily
noremap <Leader>c :ccl <bar> lcl<CR>

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
