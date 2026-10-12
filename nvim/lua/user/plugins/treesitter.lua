local treesitter_status, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_status then
	return
end

treesitter.setup({
	highlight = {
		enable = true,
	},
	indent = { enable = true },

	autopairs = {
		enable = true,
	},

	-- expand/shrink selection along the syntax tree (grow to the enclosing node)
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<leader>v", -- normal: select the node under the cursor
			node_incremental = "<Tab>", -- visual: grow to the parent node
			node_decremental = "<S-Tab>", -- visual: shrink back to the child node
			scope_incremental = false,
		},
	},

	-- explicit parser list (matched to the LSP servers in lsp/mason.lua).
	-- auto_install still grabs a single parser on demand for any other filetype opened.
	ensure_installed = {
		-- editor essentials
		"lua",
		"luadoc",
		"vim",
		"vimdoc",
		"query",
		"regex",
		-- shell / build / config
		"bash",
		"make",
		"cmake",
		"dockerfile",
		"json",
		"jsonc",
		"yaml",
		"toml",
		-- web
		"html",
		"css",
		"scss",
		"javascript",
		"typescript",
		"tsx",
		"graphql",
		-- python
		"python",
		-- jvm
		"java",
		"kotlin",
		"groovy",
		-- systems
		"c",
		"cpp",
		"rust",
		"asm",
		"arduino",
		-- infra
		"terraform",
		"hcl",
		"sql",
		-- markup / docs
		"markdown",
		"markdown_inline",
		"xml",
		-- git
		"gitcommit",
		"gitignore",
		"git_rebase",
		"diff",
	},
	auto_install = true,
})
