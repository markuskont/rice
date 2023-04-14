lvim.plugins = {
  { "folke/trouble.nvim", cmd = "TroubleToggle" },
  { "morhetz/gruvbox" },
  { "olexsmir/gopher.nvim" },
  { "leoluz/nvim-dap-go" },
  { "AckslD/swenv.nvim" },
}

lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "gruvbox"
vim.opt.relativenumber = true

lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "go",
  "gomod"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

local formatters = require "lvim.lsp.null-ls.formatters"
-- Go

formatters.setup {
  { command = "goimports", filetypes = { "go" } },
  { command = "gofumpt", filetypes = { "go" } },
}
local lsp_manager = require "lvim.lsp.manager"
lsp_manager.setup("golangci_lint_ls", {
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

lsp_manager.setup("gopls", {
  on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
  settings = {
    gopls = {
      usePlaceholders = true,
      gofumpt = true,
      codelenses = {
        generate = false,
        gc_details = true,
        test = true,
        tidy = true,
      },
    },
  },
})

local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
  return
end

gopher.setup {
  commands = {
    go = "go",
    gomodifytags = "gomodifytags",
    gotests = "gotests",
    impl = "impl",
    iferr = "iferr",
  },
}
lvim.builtin.which_key.mappings["L"] = {
  name = "Go",
  i = { "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies" },
  t = { "<cmd>GoMod tidy<cr>", "Tidy" },
  a = { "<cmd>GoTestAdd<Cr>", "Add Test" },
  A = { "<cmd>GoTestsAll<Cr>", "Add All Tests" },
  e = { "<cmd>GoTestsExp<Cr>", "Add Exported Tests" },
  g = { "<cmd>GoGenerate<Cr>", "Go Generate" },
  f = { "<cmd>GoGenerate %<Cr>", "Go Generate File" },
  c = { "<cmd>GoCmt<Cr>", "Generate Comment" },
}
local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
  return
end

dapgo.setup()

-- Python
formatters.setup {
  { command = "autopep8", filetypes = { "python" } },
}

-- Set a linter.
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
}

lvim.builtin.which_key.mappings["P"] = {
  name = "Python",
  i = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Pick Env" },
  d = { "<cmd>lua require('swenv.api').get_current_venv()<cr>", "Show Env" },
}
