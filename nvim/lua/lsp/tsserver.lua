local M = {}

M.setup = function(on_attach, capabilities)
    local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
    if status_ok then
        capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    end
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.preselectSupport = true
    capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
    capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
    capabilities.textDocument.completion.completionItem.deprecatedSupport = true
    capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
    capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        }
    }

    -- npm install -g typescript typescript-language-server
    require'lspconfig'.tsserver.setup({
        handlers = handlers,
        capabilities = capabilities,
        init_options = require("nvim-lsp-ts-utils").init_options,
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false

            require("nvim-lsp-ts-utils").setup_client(client)
            require("nvim-lsp-ts-utils").setup ({
                debug = false,
                disable_commands = false,
                enable_import_on_completion = true,
                import_all_timeout = 5000, -- ms,
                import_all_priorities = {
                    same_file = 1, -- add to existing import statement
                    local_files = 2, -- git files or files with relative path markers
                    buffer_content = 3, -- loaded buffer content
                    buffers = 4, -- loaded buffer names
                },
                import_all_scan_buffers = 100,
                import_all_select_source = false,
                -- if false will avoid organizing imports
                always_organize_imports = true,

                -- eslint
                eslint_enable_code_actions = false,
                eslint_enable_disable_comments = false,
                eslint_bin = 'eslint_d',
                eslint_config_fallback = nil,
                eslint_enable_diagnostics = false,
                eslint_opts = {
                    -- diagnostics_format = "#{m} [#{c}]",
                    condition = function(utils)
                        return utils.root_has_file(".eslintrc.js")
                    end,
                },

                -- formatting
                enable_formatting = true,
                formatter = 'prettier',
                formatter_config_fallback = nil,

                -- parentheses completion
                complete_parens = false,
                signature_help_in_parens = false,

                -- update imports on file move
                update_imports_on_move = true,
                require_confirmation_on_move = true,
                watch_dir = nil,

                -- filter diagnostics
                filter_out_diagnostics_by_severity = {},
                filter_out_diagnostics_by_code = {},

                -- inlay hints
                auto_inlay_hints = false,
                inlay_hints_highlight = "Comment",
                inlay_hints_priority = 200, -- priority of the hint extmarks
                inlay_hints_throttle = 150, -- throttle the inlay hint request
                inlay_hints_format = { -- format options for individual hint kind
                Type = {},
                Parameter = {},
                Enum = {},
            },

        })
        -- no default maps, so you may want to define some here
        local opts = { silent = true }
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        buf_set_keymap("n", "gs", ":TSLspOrganize<CR>", opts)
        buf_set_keymap("n", "<leader>cn", ":TSLspRenameFile<CR>", opts)
        buf_set_keymap("n", "<leader>i", ":TSLspImportAll<CR>", opts)

    end
    })

    --local null_ls = require("null-ls")
    --null_ls.setup({
    --    sources = {
    --        null_ls.builtins.diagnostics.eslint.with({
    --            preffer_local = 'node_modules/.bin'
    --        }), -- eslint or eslint_d
    --        null_ls.builtins.code_actions.eslint.with({
    --            preffer_local = 'node_modules/.bin'
    --        }), -- eslint or eslint_d
    --        null_ls.builtins.formatting.prettier.with({
    --            preffer_local = 'node_modules/.bin'
    --        }) -- prettier, eslint, eslint_d, or prettierd
    --    },
    --    on_attach = on_attach
    --})
end
return M
