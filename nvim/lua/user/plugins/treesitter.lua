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

	ensure_installed = "all",
	auto_install = true,
})
