local n_keymap = function(lhs, rhs)
    vim.api.nvim_set_keymap('n', lhs, rhs, { noremap = true, silent = true })
end
n_keymap("<Leader>f","<cmd>Telescope find_files<Cr>")
n_keymap("<Leader>r","<cmd>Telescope live_grep<Cr>")
n_keymap("\\","<cmd>Telescope buffers<cr>")
n_keymap("<Leader>h","<cmd>Telescope help_tags<cr>")
