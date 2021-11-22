function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" au FileType go let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
au FileType go let g:go_auto_type_info = 1
au FileType go let g:go_highlight_build_constraints = 1
au FileType go let g:go_highlight_extra_types = 1
au FileType go let g:go_highlight_fields = 1
au FileType go let g:go_highlight_functions = 1
au FileType go let g:go_highlight_methods = 1
au FileType go let g:go_highlight_operators = 1
au FileType go let g:go_highlight_structs = 1
au FileType go let g:go_highlight_types = 1
au FileType go let g:go_gopls_enabled = 1
au FileType go let g:go_auto_sameids = 0

" au FileType go let g:go_fmt_command = "goimports"
" au FileType go let g:go_list_type = "quickfix"

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
