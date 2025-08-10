vim.opt.termguicolors = true

require('lualine').setup
{
	options =
	{
		icons_enabled = true,
		theme = 'auto',
		component_separators =
		{ left = '', right = '' },
		section_separators =
		{ left = '', right = '' },
		disabled_filetypes =
		{
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh =
		{
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16, -- ~60fps
			events =
			{
				'WinEnter',
				'BufEnter',
				'BufWritePost',
				'SessionLoadPost',
				'FileChangedShellPost',
				'VimResized',
				'Filetype',
				'CursorMoved',
				'CursorMovedI',
				'ModeChanged',
			},
		}
	},
	sections =
	{
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections =
	{
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}

require('bufferline').setup { options = { mappings = true, ... } }

require("nvim-autopairs").setup {}

require("bufferline").setup {
	options = {
		numbers = "none",          -- показывать номера буферов: none | ordinal | buffer_id | смешанные варианты
		close_command = "bdelete! %d", -- команда закрытия буфера
		right_mouse_command = "bdelete! %d",
		left_mouse_command = "buffer %d",
		middle_mouse_command = nil,
		indicator = { style = "underline" }, -- стиль индикатора активного буфера
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 30,
		max_prefix_length = 15, -- максимальная длина префикса
		tab_size = 21,
		diagnostics = "nvim_lsp", -- показывать ошибки от LSP
		diagnostics_update_in_insert = false,
		offsets = { { filetype = "NvimTree", text = "File Explorer", padding = 1 } },
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		persist_buffer_sort = true,
		separator_style = "thin", -- стиль разделителей: "thick" | "thin" | "slant"
		enforce_regular_tabs = false,
		always_show_bufferline = true,
		hover = {
			enabled = true,
			delay = 200,
			reveal = { 'close' }
		},
	}
}

require("nvim-tree").setup()

require("nvim-lsp-installer").setup()

require("mason").setup()

require("mason-lspconfig").setup()

-- Подключаем cmp
local cmp = require('cmp')

cmp.setup({
	snippet = {
		-- Конфигурация расширения сниппетов
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	window = {
		-- Окна автодополнения с рамкой (опционально, улучшает визуал)
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' }, -- Источник из LSP
		{ name = 'vsnip' }, -- Источник сниппетов
	}, {
		{ name = 'buffer' }, -- Источник из открытого буфера
	}),
})

-- Настройка для командной строки / и ?
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Настройка для командной строки :
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})

-- Подключаем capabilities для LSP (интеграция с cmp)
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Настройка LSP-серверов

-- clangd (C/C++)
require('lspconfig').clangd.setup {
	capabilities = capabilities,
}

require('lspconfig').lua_ls.setup {
	capabilities = capabilities,
}

require('lspconfig').bashls.setup {
	capabilities = capabilities,
}

require('lspconfig').rust_analyzer.setup {
	capabilities = capabilities,
}
