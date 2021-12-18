local lint = require "lint"

lint.linters_by_ft = {
  javascript = {"eslint"},
  go = {'golangcilint'},
  python = {'flake8'},
}

vim.cmd([[au BufEnter *.js lua require('lint').try_lint() ]])
vim.cmd([[au BufWritePost *.js lua require('lint').try_lint() ]])
