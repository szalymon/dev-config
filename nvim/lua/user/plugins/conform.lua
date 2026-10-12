local conform_status, conform = pcall(require, "conform")
if not conform_status then
	return
end

conform.setup({
	-- external formatters per filetype; anything not listed here falls back to
	-- the language server's own formatter (terraform-ls, rust_analyzer, clangd, lua_ls, ...)
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		less = { "prettier" },
		html = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
	},
	default_format_opts = {
		-- use the LSP formatter when no formatter above matches the filetype
		lsp_format = "fallback",
	},
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback",
	},
})

-- ensure the formatters referenced above are installed via mason
local mason_conform_status, mason_conform = pcall(require, "mason-conform")
if mason_conform_status then
	mason_conform.setup()
end
