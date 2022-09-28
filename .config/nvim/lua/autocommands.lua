vim.cmd [[
  augroup _lsp
    autocmd!
    autocmd BufWritePost *.go lua vim.lsp.buf.formatting()
  augroup end
]]
