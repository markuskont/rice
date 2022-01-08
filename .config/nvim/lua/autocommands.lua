vim.cmd [[
  augroup _lsp
    autocmd!
    autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
  augroup end
]]

