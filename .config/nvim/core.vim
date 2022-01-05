" play nice with tiling window manager splits
autocmd VimResized * wincmd =

" Some vim bindings were made with english keyboard layout in mind
" Jump paragraph is really awkward with Estonian keyboard (AltGr+7,AlgGr+0)
map ü {(
map õ })

" paste mode on/off
set pastetoggle=<F2>

" visuzlize special chars
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

noremap <Leader>Y "*y
noremap <Leader>P "*p
noremap <Leader>y "+y
noremap <Leader>p "+p

" Core leader mappings
" Close quickfix windows easily
noremap <Leader>c :ccl <bar> lcl<CR>

au FileType yaml set cursorcolumn
au FileType python set cursorcolumn
au FileType ansible set cursorcolumn
au FileType jinja2 set cursorcolumn
au FileType markdown set cursorcolumn
