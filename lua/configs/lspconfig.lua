-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "clangd", "ts_ls", "gopls", "rust_analyzer", "jsonls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
-- Load Mason's registry
local ok, mason_registry = pcall(require, 'mason-registry')
if not ok then
  vim.notify 'mason-registry could not be loaded'
  return
end

-- Get Angular Language Server's install path from Mason
local angularls_path = mason_registry.get_package('angular-language-server'):get_install_path()

-- Define the command to start ngserver with correct paths
local cmd = {
  'ngserver',
  '--stdio',
  '--tsProbeLocations',
  table.concat({
    angularls_path,
    vim.uv.cwd(),
  }, ','),
  '--ngProbeLocations',
  table.concat({
    angularls_path .. '/node_modules/@angular/language-server',
    vim.uv.cwd(),
  }, ','),
}

-- LSP configuration for angularls
local config = {
  cmd = cmd,   -- The dynamically built command
  on_new_config = function(new_config, new_root_dir)
    -- Update the command with new configuration if needed
    new_config.cmd = cmd
  end,
  root_dir = require('lspconfig').util.root_pattern('angular.json', '.git'),   -- Detect Angular projects
  filetypes = { 'typescript', 'html', 'typescriptreact' },                     -- File types for Angular
  capabilities = require('nvchad.configs.lspconfig').capabilities,             -- Capabilities, like autocompletion
  on_attach = require('nvchad.configs.lspconfig').on_attach,                   -- Attach custom LSP behaviors
}

-- Setup angularls with the dynamically generated configuration
lspconfig.angularls.setup(config)
-- configuring single server, example: typescript
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

