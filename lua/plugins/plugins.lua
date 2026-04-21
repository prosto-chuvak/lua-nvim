-- MIGRATION: plugins.lua - конвертация packer.nvim → lazy.nvim
-- Все плагины теперь объявляются в формате lazy.nvim

local M = {}

-- Вспомогательная функция для создания спецификации плагина
---@param spec table
---@return table
local function plugin(spec)
  return spec
end

M.plugins = {
  -- ==========================
  -- ЦВЕТОВЫЕ СХЕМЫ (priority)
  -- ==========================
  {
    "Shayan-Neovim/ayu.nvim",
    priority = 1000, -- Загружается ДО всех UI-плагинов
    lazy = false,    -- Не ленивая загрузка для colorscheme
    config = function()
      vim.cmd("colorscheme ayu")
    end,
  },

  { "kyazdani42/nvim-web-devicons", lazy = true },

  -- ==========================
  -- LUALINE (statusline)
  -- ==========================
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = true,
        theme = "ayu",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = {}, winbar = {} },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
          refresh_time = 16,
          events = {
            "WinEnter",
            "BufEnter",
            "BufWritePost",
            "SessionLoadPost",
            "FileChangedShellPost",
            "VimResized",
            "Filetype",
            "CursorMoved",
            "CursorMovedI",
            "ModeChanged",
          },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    },
  },

  -- ==========================
  -- BUFFERLINE (табы)
  -- ==========================
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        numbers = "none",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = { style = "underline" },
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 30,
        max_prefix_length = 15,
        tab_size = 21,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        offsets = { { filetype = "NvimTree", text = "File Explorer", padding = 1 } },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },
    },
  },

  -- ==========================
  -- TAGBAR (структура файла)
  -- ==========================
  {
    "majutsushi/tagbar",
    cmd = "TagbarToggle",
  },

  -- ==========================
  -- NVIM-TREE (файловый менеджер)
  -- ==========================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeFocus" },
    keys = { { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree" } },
    opts = {},
  },

  -- ==========================
  -- VIM-TERMINAL / CSS-COLOR
  -- ==========================
  { "tc50cal/vim-terminal", cmd = "VimTerminal" },
  { "ap/vim-css-color", ft = "css" },
  { "rafi/awesome-vim-colorschemes", lazy = true },

  -- ==========================
  -- TELESCOPE (поиск)
  -- ==========================
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    },
    opts = {},
  },

  -- ==========================
  -- NVIM-AUTOPIAIRS (скобки)
  -- ==========================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- ==========================
  -- LSP & MASON
  -- ==========================
  { "neovim/nvim-lspconfig", lazy = true },
  { "williamboman/mason.nvim", cmd = "Mason" },
  { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" }, lazy = true },

  -- ==========================
  -- CMP (автодополнение)
  -- ==========================
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    },
    ---@param cmp cmp.ConfigSchema
    opts = function()
      local cmp = require("cmp")
      return {
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" },
        }, {
          { name = "buffer" },
        }),
      }
    end,
  },

  -- cmdline настройки для cmp
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },

  -- ==========================
  -- TREESITTER
  -- ==========================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { "c", "cpp", "rust", "lua", "bash" },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  -- ==========================
  -- ALE (линтер)
  -- ==========================
  { "dense-analysis/ale", event = "BufReadPost" },

  -- ==========================
  -- RUSCMD (русские команды)
  -- ==========================
  { "powerman/vim-plugin-ruscmd", lazy = true },

  -- ==========================
  -- LSP SERVER CONFIGS
  -- ==========================
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- clangd (C/C++)
      require('lspconfig').clangd.setup {
        capabilities = capabilities,
      }

      -- Lua
      require('lspconfig').lua_ls.setup {
        capabilities = capabilities,
      }

      -- Bash
      require('lspconfig').bashls.setup {
        capabilities = capabilities,
      }

      -- Rust
      require('lspconfig').rust_analyzer.setup {
        capabilities = capabilities,
      }
    end,
  },
}

return M.plugins
