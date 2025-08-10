vim.keymap.set('n', '<C-s>', ':w<CR>', { silent = true })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>', { silent = true })
vim.keymap.set('n', '<C-x>', ':wq<CR>', { silent = true })
vim.keymap.set('i', '<C-x>', '<Esc>:wq<CR>', { silent = true })
vim.keymap.set('n', '<C-f>', ':q<CR>', { silent = true })
vim.g.mapleader = ' '
