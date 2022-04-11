local plugins = {'autopairs','cmp', 'lualine','telescope','treesitter', 'lsp_installer'}
for _, plugin in ipairs(plugins) do
    require("plugins." .. plugin)
end
