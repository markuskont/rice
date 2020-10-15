" FZF bindings
nnoremap <leader>f :FZF<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>L :BLines<CR>
nnoremap <leader>B :Buffers<CR>
nnoremap <leader>W :Windows<CR>
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>G :GFiles?<CR>
nnoremap <leader>m :Markus<CR>
nnoremap <leader>h :History:<CR>
nnoremap <leader>H :History<CR>

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
