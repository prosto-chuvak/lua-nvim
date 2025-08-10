---------------------------------
-- Базовые настройки редактора --
---------------------------------

local opt = vim.opt

opt.number = true
opt.autoindent = true
opt.encoding = 'utf-8'
opt.tabstop = 3
opt.shiftwidth = 3
opt.smarttab = true
opt.softtabstop = 3
opt.swapfile = false
opt.mouse = 'a'
opt.ignorecase = true
opt.smartcase = true
opt.clipboard:append('unnamedplus')