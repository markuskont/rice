-- nvim_lsp object
local nvim_lsp = require'lspconfig'
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

capabilities.textDocument.completion.completionItem.snippetSupport = true

--
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  client.resolved_capabilities.document_formatting = false

end

local servers = { 'gopls', 'pyright', 'rust_analyzer', 'tsserver', 'html'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- local configs = require 'lspconfig.configs'
-- -- Check if the config is already defined (useful when reloading this file)
-- if not configs.suricata_language_server then
--   configs.suricata_language_server = {
--     default_config = {
--       cmd = {'suricata-language-server'};
--       filetypes = {'suricata', 'hog'};
--       root_dir = function(fname)
--         return nvim_lsp.util.find_git_ancestor(fname)
--       end;
--       single_file_support = true;
--       settings = {};
--     };
--   }
-- end

-- local suricata_ls_cmd = {'suricata-language-server', '--suricata-binary=/home/markus/Tools/Suricata/7-dev-latest/bin/suricata'}
-- require'lspconfig'.suricata_language_server.setup{
--   cmd = suricata_ls_cmd,
--   on_attach = on_attach,
-- }
