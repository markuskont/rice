local lint = require "lint"

lint.linters_by_ft = {
  javascript = {"eslint"},
  go = {'golangcilint'},
  python = {'flake8'},
}

vim.cmd([[au BufEnter * lua require('lint').try_lint() ]])
vim.cmd([[au BufWritePost * lua require('lint').try_lint() ]])
