"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

set rtp+="/usr/bin/fzf"

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

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

set background=dark
"let g:solarized_termcolors=256
""colorscheme solarized
color dracula

" Folds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
" Does not make senso to highlight folded code, point is to remove it from
" visual spam
" "highlight Folded cterm=None

" scratch window is annoying and does not play nice with splits
set completeopt-=preview

filetype plugin indent on
set relativenumber
set nu

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

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
au FileType go setl foldmethod=indent foldcolumn=2
au FileType go let g:go_fmt_experimental=1
au FileType go let g:go_highlight_types = 1
au FileType go let g:go_highlight_fields = 1
au FileType go let g:go_highlight_functions = 1
au FileType go let g:go_highlight_function_calls = 1
au FileType go let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-go/gosnippets/UltiSnips/"
au FileType go map <C-n> :cnext<CR>
au FileType go map <C-m> :cprevious<CR>
au FileType go nnoremap <leader>a :cclose<CR>

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

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
