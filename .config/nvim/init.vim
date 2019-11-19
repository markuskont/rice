" Core functions
" May be needed for building plugins written in rust
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

function WordCount()
  let s:old_status = v:statusmsg
  exe "silent normal g\<c-g>"
  let s:word_count = str2nr(split(v:statusmsg)[11])
  let v:statusmsg = s:old_status
  return s:word_count
endfunction

set switchbuf+=useopen
function! TermEnter()
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, "term://") > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
        break
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches >= 1)
    execute ":sbuffer ". firstmatchingbufnr
    startinsert
  else
    execute ":terminal"
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Install plugins
call plug#begin('~/.local/nvim')
" Cannot live without
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Color schemes
Plug 'https://github.com/dracula/vim.git', { 'dir': '~/.vim/plug/dracula-theme' }
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'

" Coding helpers
" Core stuff
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'honza/vim-snippets'
Plug 'AndrewRadev/splitjoin.vim'

" Golang
Plug 'fatih/vim-go'
" Rust
Plug 'rust-lang/rust.vim'
" R
Plug 'jalvesaq/Nvim-R'
" CSV
Plug 'chrisbra/csv.vim'
" Ansible
Plug 'pearofducks/ansible-vim'
call plug#end()

" Main configs
" Color scheme
if !empty($VIM_COLOR)
  colorscheme $VIM_COLOR
else
  set background=dark
  colorscheme gruvbox
endif

" play nice with tiling window manager splits
autocmd VimResized * wincmd =

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
" autoclose quotes, brackets etc
ino ' ''<left>
ino " ""<left>
ino { {}<left>
ino [ []<left>
ino ( ()<left>

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

" FZF bindings
nnoremap <leader>f :FZF<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>B :Buffers<CR>

" FZF configs
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Airline
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#wordcount#formatter = 'default'
let g:airline#extensions#wordcount#formatter#default#fmt = '%s words'
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1

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

" coc settings
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Language specific configs
" golang
au FileType go let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
au FileType go let g:go_auto_type_info = 0
au FileType go let g:go_highlight_build_constraints = 1
au FileType go let g:go_highlight_extra_types = 1
au FileType go let g:go_highlight_fields = 1
au FileType go let g:go_highlight_functions = 1
au FileType go let g:go_highlight_methods = 1
au FileType go let g:go_highlight_operators = 1
au FileType go let g:go_highlight_structs = 1
au FileType go let g:go_highlight_types = 1
au FileType go let g:go_fmt_command = "goimports"
au FileType go let g:go_list_type = "quickfix"

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
au FileType go nmap <leader>t  <Plug>(go-test)

au FileType go nmap <leader>a :GoAlternate<CR>
au FileType go nmap <leader>d :GoDoc<CR>
au FileType go nmap <leader>r :GoReferrers<CR>
au FileType go nmap <leader>id :GoSameIds<CR>
au FileType go nmap <leader>idc :GoSameIdsClear<CR>
au FileType go nmap <leader>gt :GoDeclsDir<cr>
au FileType go nmap <leader>i :GoInstall<cr>
au FileType go nmap <leader>im :GoImport<cr>
au FileType go nmap <leader>ipl :GoImpl<cr>

au FileType yaml setlocal et ts=2 ai sw=2 nu sts=0
au FileType yaml set cursorline

" Rust

" Python
au FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

py3 << EOF
import os, sys, pathlib
if 'VIRTUAL_ENV' in os.environ:
    venv = os.getenv('VIRTUAL_ENV')
    site_packages = next(pathlib.Path(venv, 'lib').glob('python*/site-packages'), None)
    if site_packages:
        sys.path.insert(0, str(site_packages))
EOF
