local lsp_installer = require("nvim-lsp-installer")

lsp_installer.setup({
ensure_installed = { "sumneko_lua"},
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})
