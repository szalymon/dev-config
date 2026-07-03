local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local keymap = vim.keymap

-- set buffer-local keybinds whenever a language server attaches (replaces on_attach)
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		-- keybind options
		local opts = { noremap = true, silent = true, buffer = ev.buf }

		-- set keybinds
		keymap.set("n", "gf", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
		keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
		keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
		keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
		keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
		keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
		keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
		keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
		keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
		keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
		keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
		keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts) -- see outline on right hand side
	end,
})

-- used to enable autocompletion (assigned to every lsp server via the "*" config below)
local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- diagnostic signs (new vim.diagnostic API; merges with existing diagnostic config)
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})

-- default config applied to every language server
vim.lsp.config("*", {
	capabilities = capabilities,
})

-- emmet (extra filetypes + init options)
vim.lsp.config("emmet_ls", {
	filetypes = { "html", "htmldjango", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
})

-- lua server (with special settings)
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

-- terraform: nvim-lspconfig's bundled config calls vim.lsp.codelens.enable in
-- on_attach, which only exists on nvim 0.12+; guard it so it doesn't error on 0.11.
vim.lsp.config("terraformls", {
	on_attach = function(_, bufnr)
		if vim.lsp.codelens.enable then
			vim.lsp.codelens.enable(true, { bufnr = bufnr })
		end
	end,
})

-- enable language servers (configs come from nvim-lspconfig's lsp/ directory)
vim.lsp.enable({
	"html",
	"ts_ls",
	"emmet_ls",
	"cssls",
	"jsonls",
	"lua_ls",
	"jedi_language_server",
	"terraformls",
	"tflint",
	"clangd",
	"rust_analyzer",
	"jdtls",
})
