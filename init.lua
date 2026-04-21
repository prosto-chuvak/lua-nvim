------------------------
-- Bootstrap lazy.nvim --
------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

------------------------
-- Импорт модулей Lua --
------------------------

require('setting/setting')
require('setting/setting-plugins')
require('keymaps/keymaps')

-- MIGRATION: colorscheme загружается через lazy с priority
-- require('plugins/Packer') -- удалено (packer.nvim)
-- require('keymaps/keymaps-plugins') -- переносится после lazy.setup()

-- Загрузка плагинов через lazy
require("lazy").setup("plugins", {
  install = {
    colorscheme = { "ayu" },
  },
  checker = {
    enabled = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

require('keymaps/keymaps-plugins')
