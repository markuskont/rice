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

"command! -bang -nargs=* Ag call fzf#vim#ag_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))
"command! -bang -nargs=* Rg call fzf#vim#rg_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))

" Main configs
" Color scheme
if !empty($VIM_COLOR)
  colorscheme $VIM_COLOR
else
  set termguicolors
  set background=dark
  colorscheme gruvbox
endif

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
" Disable
let g:fzf_buffers_jump = 0
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

"let g:ale_linters = {'rust': ['analyzer']}
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \}

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

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `g[` and `g]` to navigate diagnostics
" Adjusted for nordic keyboard
nmap <silent> gü <Plug>(coc-diagnostic-prev)
nmap <silent> gõ <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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
au FileType go let g:go_gopls_enabled = 1

au FileType go let g:go_fmt_command = "goimports"
au FileType go let g:go_list_type = "quickfix"
" au FileType go let CursorHold * silent call CocActionAsync('highlight')

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

au FileType go set colorcolumn=100
au FileType go set spell&

au FileType yaml setlocal et ts=2 ai sw=2 nu sts=0
au FileType yaml set list

set cursorline
au FileType yaml set cursorcolumn
au FileType python set cursorcolumn
au FileType ansible set cursorcolumn
au FileType jinja2 set cursorcolumn
au FileType markdown set cursorcolumn

" Rust

" Python
au FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
au FileType python set colorcolumn=100

autocmd Filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>
autocmd Filetype ipynb nmap <silent><Leader>n :VimpyterStartNteract<CR>

" Latex/markdown
au FileType markdown set spell
au FileType tex set spell

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>
