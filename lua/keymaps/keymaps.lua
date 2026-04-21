-- MIGRATION: keymaps.lua - базовые маппинги
-- Используется современный vim.keymap.set API

local map = vim.keymap.set

-- Сохранение и закрытие
map('n', '<C-s>', ':w<CR>', { silent = true, desc = 'Save file' })
map('i', '<C-s>', '<Esc>:w<CR>', { silent = true, desc = 'Save file' })
map('n', '<C-x>', ':wq<CR>', { silent = true, desc = 'Save and quit' })
map('i', '<C-x>', '<Esc>:wq<CR>', { silent = true, desc = 'Save and quit' })
map('n', '<C-f>', ':q<CR>', { silent = true, desc = 'Quit' })

-- Leader key
vim.g.mapleader = ' '
