-- MIGRATION: keymaps-plugins.lua - маппинги для плагинов
-- Загружается после lazy.setup()

local map = vim.keymap.set

-- NvimTree
map('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = 'Toggle NvimTree' })

-- Bufferline
map('n', '<leader>w', ':BufferLineCycleNext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })
map('n', '<leader>s', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true, desc = 'Prev buffer' })
map('n', '<leader>l', ':BufferLineCloseLeft<CR>', { noremap = true, silent = true, desc = 'Close left buffers' })
map('n', '<leader>r', ':BufferLineCloseRight<CR>', { noremap = true, silent = true, desc = 'Close right buffers' })

-- Telescope
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
