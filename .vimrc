" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plug')

Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'sirver/UltiSnips'
Plug 'https://github.com/dracula/vim.git', { 'dir': '~/.vim/plug/dracula-theme' }

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'zchee/deoplete-go', { 'do': 'make'}

" Initialize plugin system
call plug#end()

let mapleader = ','

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 'ignorecase'
let g:deoplete#sources#go = 'vim-go'
let g:deoplete#sources#jedi#python_path = 'python3'
set completeopt+=noinsert
set completeopt-=preview
autocmd BufReadPost * call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy', 'matcher_length', 'camel_case'])

noremap <Leader>c :ccl <bar> lcl<CR>
"let windo if &buftype != "quickfix" | lclose | endif

function WordCount()
  let s:old_status = v:statusmsg
  exe "silent normal g\<c-g>"
  let s:word_count = str2nr(split(v:statusmsg)[11])
  let v:statusmsg = s:old_status
  return s:word_count
endfunction


"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

nnoremap <leader>f :FZF<CR>
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

set tabstop=2       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=2    " Indents will have a width of 4
set softtabstop=2   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces

set autochdir

" plugin manager
execute pathogen#infect()

" automatic NERDtree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

set pastetoggle=<F2>

set timeoutlen=1000 ttimeoutlen=0

" ==============================
" Programming stuff
" ==============================

syntax on

set hidden

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Airline
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#wordcount#formatter = 'default'

let g:airline#extensions#wordcount#formatter#default#fmt = '%s words'

let g:airline_powerline_fonts = 1


" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1

" Syntastic airline integration???
let g:airline#extensions#syntastic#enabled = 1
"call airline#parts#define_accent('syntastic', 'yellow')
let airline#extensions#syntastic#warning_symbol = 'W:'
let airline#extensions#syntastic#stl_format_warn = '%W{[%w(#%fw)]}'

let airline#extensions#syntastic#error_symbol = 'E:'
let airline#extensions#syntastic#stl_format_err = '%E{[%e(#%fe)]}'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"

set background=dark
"let g:solarized_termcolors=256
"colorscheme solarized
color dracula

" Folds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

"autocmd BufWrite * mkview
"autocmd BufRead * silent loadview
"augroup remember_folds
"  autocmd!
"  autocmd BufWinLeave * mkview
"  autocmd BufWinEnter * silent! loadview
"augroup END

vnoremap <Space> zf
" Does not make senso to highlight folded code, point is to remove it from
" visual spam
" "highlight Folded cterm=None

" scratch window is annoying and does not play nice with splits
set completeopt-=preview

filetype plugin indent on
set relativenumber
set nu

" visualize special chars
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" set list
" autoclose quotes, brackets etc
ino ' ''<left>
ino " ""<left>
ino { {}<left>
ino [ []<left>
ino ( ()<left>

"inoremap (      ()<Left>
"inoremap (<CR>  (<CR>)<Esc>O
"inoremap ((     (
"inoremap (      ()<Left>


"inoremap {      {}<Left>
"inoremap {<CR>  {<CR>}<Esc>O
"inoremap {     {
"inoremap {}     {}
"
"inoremap [      []<Left>
"inoremap [<CR>  [<CR>]<Esc>O
"inoremap [     [
"inoremap []     []

" ===========================================================
" FileType specific changes
" ============================================================
" Javascript
au BufRead *.js set makeprg=jslint\ %
" Use tab to scroll through autocomplete menus
"autocmd VimEnter * imap <expr> <Tab> pumvisible() ? "<C-N>" : "<Tab>"
"autocmd VimEnter * imap <expr> <S-Tab> pumvisible() ? "<C-P>" : "<S-Tab>"
autocmd filetype javascript set sw=2 ts=2 expandtab
let g:acp_completeoptPreview=1

" Mako/HTML
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
autocmd FileType html,xhtml,xml,css setlocal expandtab shiftwidth=2 tabstop=2

" ==========================================================
" Python
" ==========================================================

"au BufRead *.py compiler nose
"au FileType python set omnifunc=pythoncomplete#Complete
au FileType python set omnifunc=jedi#completions
au FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
au FileType python set foldmethod=indent foldlevel=99

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**


"python with virtualenv support
"python3 << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  if os.path.exists(activate_this): 
"    exec(compile(open(activate_this).read(), activate_this, 'exec'), {'__file__': activate_this})
"EOF

py3 << EOF
import os, sys, pathlib
if 'VIRTUAL_ENV' in os.environ:
    venv = os.getenv('VIRTUAL_ENV')
    site_packages = next(pathlib.Path(venv, 'lib').glob('python*/site-packages'), None)
    if site_packages:
        sys.path.insert(0, str(site_packages))
EOF

" =========================================================
" Golang
" =========================================================
" au FileType golang setlocal omnifunc=go#complete#Complete foldmethod=marker foldmarker={,} foldlevel=2
au FileType go setlocal omnifunc=go#complete#Complete
"au FileType go setlocal omnifunc=
au FileType go setl foldmethod=indent foldcolumn=2
au FileType go map <C-n> :cnext<CR>
au FileType go map <C-m> :cprevious<CR>
"au FileType go nnoremap <leader>a :cclose<CR>
au FileType go nnoremap <leader>a :GoAlternate<CR>
au FileType go nnoremap <leader>d :GoDoc<CR>

"let g:deoplete#sources#go#cgo = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" use goimports for formatting
let g:go_fmt_command = "goimports"

" turn highlighting on
let g:go_fmt_experimental=1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

" Open go doc in vertical window, horizontal, or tab
au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
au Filetype go nnoremap <leader>t :tab split <CR>:exe "GoDef"<CR>

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>i  <Plug>(go-install)

""au FileType go let g:go_list_type = "quickfix"
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" =========================================================
" LaTeX
" =========================================================

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
au FileType tex set spell spelllang=en_us
