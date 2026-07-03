-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		-- core
		{ "nvim-lua/plenary.nvim", lazy = true },

		-- which-key
		{ "folke/which-key.nvim", config = function() require("user.plugins.whichkey") end },

		-- colorschemes (load eagerly; onedark applies the scheme via colorscheme.lua,
		-- which also calls catppuccin.setup, so catppuccin must load first)
		{ "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 },
		{ "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
		{
			"navarasu/onedark.nvim",
			lazy = false,
			priority = 1000,
			dependencies = { "catppuccin" },
			config = function() require("user.core.colorscheme") end,
		},

		-- editing essentials (Lua replacements for vim-surround / ReplaceWithRegister)
		{ "kylechui/nvim-surround", version = "*", event = "VeryLazy", config = true },
		{
			"gbprod/substitute.nvim",
			event = "VeryLazy",
			config = function() require("substitute").setup() end,
		},

		-- dashboard
		{ "goolord/alpha-nvim", config = function() require("user.plugins.alpha") end },

		-- comments
		{ "numToStr/Comment.nvim", config = function() require("user.plugins.comment") end },

		-- file explorer
		{
			"nvim-tree/nvim-tree.lua",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function() require("user.plugins.nvim-tree") end,
		},

		-- statusline
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function() require("user.plugins.lualine") end,
		},

		-- bufferline
		{
			"akinsho/bufferline.nvim",
			version = "*",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function() require("user.plugins.bufferline") end,
		},

		-- treesitter
		-- pinned to the master branch: the config in user.plugins.treesitter uses the
		-- classic `nvim-treesitter.configs` API, which the new default `main` branch removed.
		{
			"nvim-treesitter/nvim-treesitter",
			branch = "master",
			build = ":TSUpdate",
			config = function() require("user.plugins.treesitter") end,
		},

		-- autopairs / autotag
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = function() require("user.plugins.autopairs") end,
		},
		{
			"windwp/nvim-ts-autotag",
			ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
			config = function() require("nvim-ts-autotag").setup() end,
		},

		-- fuzzy finder
		{
			"nvim-telescope/telescope.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
				"nvim-tree/nvim-web-devicons",
			},
			config = function() require("user.plugins.telescope") end,
		},

		-- completion
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lsp",
				"saadparwaiz1/cmp_luasnip",
				"onsails/lspkind.nvim",
				{
					"L3MON4D3/LuaSnip",
					dependencies = { "rafamadriz/friendly-snippets" },
				},
			},
			config = function() require("user.plugins.nvim-cmp") end,
		},

		-- mason: install lsp servers / formatters / linters
		{ "mason-org/mason.nvim", config = function() require("user.plugins.lsp.mason") end },
		{ "mason-org/mason-lspconfig.nvim", dependencies = { "mason-org/mason.nvim" } },
		{ "jay-babu/mason-null-ls.nvim", dependencies = { "mason-org/mason.nvim" } },

		-- formatting & linting
		{ "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

		-- lsp
		{ "nvimdev/lspsaga.nvim", config = function() require("user.plugins.lsp.lspsaga") end },
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				"mason-org/mason-lspconfig.nvim",
				"hrsh7th/cmp-nvim-lsp",
				"nvimdev/lspsaga.nvim",
			},
			config = function() require("user.plugins.lsp.lspconfig") end,
		},

		-- diagnostics list
		{
			"folke/trouble.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			cmd = "Trouble",
			config = true,
		},

		-- tmux integration
		{
			"alexghergh/nvim-tmux-navigation",
			config = function() require("user.plugins.nvim-tmux-navigation") end,
		},

		-- project management
		{
			-- maintained successor to project.nvim (project switcher + sessions)
			"coffebar/neovim-project",
			lazy = false,
			priority = 100,
			init = function()
				-- required by the session manager to persist/restore session globals
				vim.opt.sessionoptions:append("globals")
			end,
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
				"Shatur/neovim-session-manager",
			},
			config = function()
				require("neovim-project").setup({
					-- globs used to discover your projects; adjust to taste
					projects = {
						"~/Work/*",
						"~/Work/*/*",
						"~/.config/*",
					},
					picker = { type = "telescope" },
					-- keep the alpha dashboard on startup instead of auto-restoring a session
					last_session_on_startup = false,
				})
			end,
		},

		-- per-project local config
		{
			"klen/nvim-config-local",
			config = function()
				require("config-local").setup({
					config_files = { ".nvim.lua", ".nvimrc", ".exrc" },
					hashfile = vim.fn.stdpath("data") .. "/config-local",
					autocommands_create = true,
					commands_create = true,
					silent = false,
					lookup_parents = false,
				})
			end,
		},
	},
	ui = { border = "rounded" },
	checker = { enabled = false },
	rocks = { enabled = false }, -- no plugins need luarocks; avoids the hererocks health error
})
