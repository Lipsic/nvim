local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({

	spec = {
		-- add your plugins and dependencies here
		-- Language Support
		-- Added this plugin.
		{
			"kylechui/nvim-surround",
			version = "*", -- Use for stability; omit to use `main` branch for the latest features
			event = "VeryLazy",
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end
		},
		{ "nvim-lua/plenary.nvim" },
		{
			'VonHeikemen/lsp-zero.nvim',
			branch = 'v1.x',

			dependencies = {
				-- LSP Support
				{ 'neovim/nvim-lspconfig' }, -- Required
				{ 'williamboman/mason.nvim' }, -- Optional
				{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

				-- Autocompletion
				{ 'hrsh7th/nvim-cmp' }, -- Required
				{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
				{ 'hrsh7th/cmp-buffer' }, -- Optional
				{ 'hrsh7th/cmp-path' }, -- Optional
				{ 'saadparwaiz1/cmp_luasnip' }, -- Optional
				{ 'hrsh7th/cmp-nvim-lua' }, -- Optional

				-- Snippets
				{ 'L3MON4D3/LuaSnip' }, -- Required
				{ 'rafamadriz/friendly-snippets' }, -- Optional
			}
		},

		-- My Favs
		{
			'nvim-lualine/lualine.nvim',
			dependencies = { 'nvim-tree/nvim-web-devicons' },
		},
		{
			"williamboman/mason.nvim"
		},
		{
			'nvim-telescope/telescope.nvim',
			tag = '0.1.8',
			cmd = 'Telescope',
			lazy = true,
			dependencies = {
				{ 'nvim-telescope/telescope-ui-select.nvim' },
				{ 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
				'nvim-lua/plenary.nvim',
				'andrew-george/telescope-themes'
			},
			config = function()
				-- load extension
				local telescope = require('telescope')
				telescope.load_extension('themes')
			end
		},

		{ 'https://github.com/nvim-treesitter/nvim-treesitter' },
		{ "catppuccin/nvim",                                   name = "catppuccin", priority = 1000 },

		{ "williamboman/mason-lspconfig.nvim" },
		{ "neovim/nvim-lspconfig" },
		{ "https://github.com/jose-elias-alvarez/null-ls.nvim" },
		{ "mfussenegger/nvim-dap" },
		{
			"leoluz/nvim-dap-go",
			ft = "go",
			dependecies = "mfussenegger/nvim-dap",
			config = function(_, opts)
				require("dap-go").setup(opts)
			end
		},
		{
			"olexsmir/gopher.nvim",
			ft = "go",
			-- branch = "develop", -- if you want develop branch
			-- keep in mind, it might break everything
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
			},
			-- (optional) will update plugin's deps on every update
			build = function()
				vim.cmd.GoInstallDeps()
			end,
			---@type gopher.Config
			opts = {},
		},

		-- Configure any other settings here. See the documentation for more details.
		-- colorscheme that will be used when installing plugins.
		install = { colorscheme = { "habamax" } },
		-- automatically check for plugin updates
		checker = { enabled = true },

		{
			"jackMort/ChatGPT.nvim",
			event = "VeryLazy",
			dependencies = {
				"MunifTanjim/nui.nvim",
				"nvim-lua/plenary.nvim",
				-- "folke/trouble.nvim", -- optional
				"nvim-telescope/telescope.nvim"
			}
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- Autocompletion
				{ 'hrsh7th/nvim-cmp' }, -- Required
				{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
				{ 'hrsh7th/cmp-buffer' }, -- Optional
				{ 'hrsh7th/cmp-path' }, -- Optional
				{ 'saadparwaiz1/cmp_luasnip' }, -- Optional
				{ 'hrsh7th/cmp-nvim-lua' }, -- Optional
				-- Snippets
				{ 'L3MON4D3/LuaSnip' }, -- Required
				{ 'rafamadriz/friendly-snippets' }, -- Optional

				-- refer to the configuration section below
			},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = true })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
			spec = {
				{ '<leader>c', group = '[C]ode',     mode = { 'n', 'x' } },
				{ '<leader>d', group = '[D]ocument' },
				{ '<leader>r', group = '[R]ename' },
				{ '<leader>s', group = '[S]earch' },
				{ '<leader>w', group = '[W]orkspace' },
				{ '<leader>t', group = '[T]oggle' },
				{ '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
			},
		},
	}
	----------------end----------------------

})
