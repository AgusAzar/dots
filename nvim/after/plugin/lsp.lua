local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'lua_ls',
})


-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.setup()
