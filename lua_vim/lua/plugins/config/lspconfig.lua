-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')
local lsp_installer = require('nvim-lsp-installer')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'yamlls', 'dockerls', 'ltex', 'rust_analyzer', 'sumneko_lua', 'kotlin_language_server' }
for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end

  lspconfig[name].setup {
	  capabilities = capabilities,
  }
end

