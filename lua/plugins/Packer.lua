vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	-------------------------
	-- ПЛАГИНЫ ВНЕШНЕГО ВИДА
	-------------------------
	-- Информационная строка внизу
	use "kyazdani42/nvim-web-devicons"
	use
	{
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function()
			require('lualine').setup()
		end,
	}

	---------------------
	-- МОДУЛИ РЕДАКТОРА
	---------------------
	-- Табы с вкладками сверху
	use
	{
		'akinsho/bufferline.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			require("bufferline").setup {}
		end,
	}

	-- Структура классов и функций в файле
	use 'majutsushi/tagbar'

	-- Файловый менеджер
	use
	{
		'kyazdani42/nvim-tree.lua',
		requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			require 'nvim-tree'.setup {}
		end,
	}

	use 'tc50cal/vim-terminal'
	use 'ap/vim-css-color'
	use 'rafi/awesome-vim-colorschemes'

	-------------
	-- ПОИСК
	-------------
	use
	{
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/plenary.nvim' } },
		config = function()
			require 'telescope'.setup {}
		end,
	}

	--------------
	-- КОД
	--------------
	-- автоматические закрывающиеся скобки
	use
	{ 'windwp/nvim-autopairs',
		config = function()
			require("nvim-autopairs").setup()
		end
	}

	--------------------------
	-- LSP И АВТОДОПОЛНЯЛКИ --
	--------------------------
	-- Collection of configurations for built-in LSP client
	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig'

	-- Автодополнялка
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'saadparwaiz1/cmp_luasnip'

	--- Автодополнлялка к файловой системе
	use 'hrsh7th/cmp-path'

	-- Snippets plugin
	use 'L3MON4D3/LuaSnip'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'


	-- Highlight, edit, and navigate code using a fast incremental parsing library
	use 'nvim-treesitter/nvim-treesitter'

	-- Линтер, работает для всех языков
	use 'dense-analysis/ale'
	---------------
	-- РАЗНОЕ
	---------------
	-- Даже если включена русская раскладка, то nvim-команды будут работать
	use 'powerman/vim-plugin-ruscmd'
end)
