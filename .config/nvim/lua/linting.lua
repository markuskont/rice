local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
    formatting.autopep8,
    formatting.stylua,
    formatting.goimports,
    diagnostics.eslint.with({ prefer_local = "node_modules/.bin" }),
    diagnostics.flake8.with({ extra_args = { "--max-line-length", "140", "--ignore=E501,E722,W504" } }),
    diagnostics.golangci_lint.with({
      extra_args = {
        "--disable-all",
        "-E", "deadcode",
        "-E", "gosimple",
        "-E", "gosec",
        "-E", "govet",
        "-E", "ineffassign",
        "-E", "staticcheck",
        "-E", "structcheck",
        "-E", "typecheck",
        "-E", "unused",
        "-E", "varcheck"
      }
    }),
  },
})
