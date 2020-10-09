" Main configs
" Color scheme
if !empty($VIM_COLOR)
  colorscheme $VIM_COLOR
else
  set termguicolors
  set background=dark
  colorscheme gruvbox
endif

