vim.g.mapleader = ','

vim.keymap.set('i','<C-c>','<Esc>')
vim.keymap.set('n','<C-L>', ':nohl<CR><C-L>')
--vim.keymap.set('i','<expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

--undo break points
vim.keymap.set('i',',', ',<C-g>u')
vim.keymap.set('i','.', '.<C-g>u')
vim.keymap.set('i','<', '<<C-g>u')
vim.keymap.set('i','>', '><C-g>u')
