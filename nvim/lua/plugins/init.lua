local plugins = { 'lsp_installer', 'autopairs', 'lspconfig', 'cmp', 'lualine', 'telescope', 'treesitter' }
for _, plugin in ipairs(plugins) do
  require("plugins." .. plugin)
end
