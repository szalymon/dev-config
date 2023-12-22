local config = {
	-- disable virtual text
	virtual_text = false,
	-- show signs
	-- signs = {
	-- 	active = signs,
	-- },
	update_in_insert = true,
	undercurl = true,
	-- underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.diagnostic.config(config)
