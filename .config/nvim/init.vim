" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plug')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'

Plug 'rust-lang/rust.vim'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}  " condensed html
Plug 'burnettk/vim-angular'
Plug 'tpope/vim-jdaddy'            " JSON text object

Plug 'derekwyatt/vim-scala'
Plug 'wannesm/wmgraphviz.vim'

Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'

Plug 'chrisbra/csv.vim'

Plug 'saltstack/salt-vim'
Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/'}
Plug 'nathanielc/vim-tickscript'
Plug 'cespare/vim-toml'

Plug 'jalvesaq/Nvim-R'
Plug 'gaalcaras/ncm-R'

Plug 'sirver/UltiSnips'
Plug 'honza/vim-snippets'

Plug 'vim-latex/vim-latex'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'https://github.com/dracula/vim.git', { 'dir': '~/.vim/plug/dracula-theme' }
Plug 'sickill/vim-monokai'
Plug 'altercation/vim-colors-solarized'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

"Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoInstallBinaries' }
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Yilin-Yang/vim-markbar'

Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'zchee/deoplete-jedi'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'zchee/deoplete-clang'
Plug 'wokalski/autocomplete-flow'
Plug 'xolox/vim-lua-ftplugin'

"Plug 'wellle/tmux-complete.vim'

" Initialize plugin system
call plug#end()

let mapleader = ','

" Maintain sanity while using quickfix
augroup quickfix
  autocmd!
  autocmd FileType qf setlocal wrap
augroup END

" http://flaviusim.com/blog/resizing-vim-window-splits-like-a-boss/
set winheight=30
"set winminheight=5

nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>

nmap <Leader>m <Plug>ToggleMarkbar


if !empty($VIM_COLOR)
  colorscheme $VIM_COLOR
else
  set background=dark
  colorscheme gruvbox
endif

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
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

nnoremap <leader>f :FZF<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>B :Buffers<CR>
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

"set autochdir

" automatic NERDtree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

set pastetoggle=<F2>

set timeoutlen=1000 ttimeoutlen=0

" ==============================
" Programming stuff
" ==============================

syntax on

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#sources#jedi#python_path = 'python3'

set completeopt+=noinsert
set completeopt-=preview

"autocmd BufReadPost * call deoplete#custom#option({ 'camel_case': v:true })
autocmd BufReadPost * call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy', 'matcher_length', 'camel_case'])

" Disable deoplete when in multi cursor mode
function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete = 1
endfunction

function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete = 0
endfunction<Paste>

" Enable completing of go pointers
let g:deoplete#sources#go#pointer = 1"

set hidden

" let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
" let g:ycm_key_list_select_completion=[]
" let g:ycm_key_list_previous_completion=[]

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Airline
let g:airline#extensions#ale#enabled = 1

let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#wordcount#formatter = 'default'

let g:airline#extensions#wordcount#formatter#default#fmt = '%s words'

let g:airline_powerline_fonts = 1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"


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
" highlight Folded cterm=None

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

" C
au FileType c let g:deoplete#sources#clang#libclang_path = '/usr/lib/x86_64-linux-gnu/libclang-6.0.so'

" Rust
au FileType rust let g:deoplete#sources#rust#racer_binary="/home/markus/.cargo/bin/racer"
au FileType rust let g:deoplete#sources#rust#rust_source_path="/home/markus/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"

" Lua
au FileType lua set omnifunc=lua_complete_omni

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

au FileType go nmap <F9> :GoCoverageToggle -short<cr>

"au FileType go let g:deoplete#sources#go#cgo = 1
au FileType go let g:deoplete#sources#go = 'vim-go'
au FileType go let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

au FileType go let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

"au FileType go let g:go_auto_sameids = 1
au FileType go let g:go_auto_type_info = 1
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

au FileType go nmap <F12> <Plug>(go-def)
" Open go doc in vertical window, horizontal, or tab
"au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
"au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
"au Filetype go nnoremap <leader>t :tab split <CR>:exe "GoDef"<CR>

au FileType go map <C-n> :cnext<CR>
au FileType go map <C-m> :cprevious<CR>

"au FileType go nmap <leader>b  <Plug>(go-build)
au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
au FileType go nmap <leader>r  <Plug>(go-run)
au FileType go nmap <leader>t  <Plug>(go-test)
au FileType go nmap <leader>d  <Plug>(go-def)

au FileType go nmap <leader>a :GoAlternate<CR>
au FileType go nmap <leader>d :GoDoc<CR>
au FileType go nmap <leader>r :GoReplace<CR>
au FileType go nmap <leader>id :GoSameIds<CR>
au FileType go nmap <leader>idc :GoSameIdsClear<CR>
au FileType go nmap <leader>gt :GoDeclsDir<cr>
au FileType go nmap <leader>i :GoInstall<cr>
au FileType go nmap <leader>im :GoImport<cr>
au FileType go nmap <leader>ipl :GoImpl<cr>

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction


" =========================================================
" LaTeX
" =========================================================

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
au FileType tex set spell spelllang=en_us
