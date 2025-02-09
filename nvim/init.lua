vim.cmd('let g:python3_host_prog = "~/.config/nvim_python/.venv/bin/python"')

require("user.plugins-setup")
require("user.core.colorscheme")
require("user.core.options")
require("user.core.keymaps")

require("user.core.diagnostics")

require("user.plugins.alpha")
require("user.plugins.comment")
require("user.plugins.nvim-tree")
require("user.plugins.lualine")
require("user.plugins.telescope")
require("user.plugins.nvim-cmp")
require("user.plugins.lsp.mason")

require("user.plugins.lsp.lspsaga")
require("user.plugins.lsp.lspconfig")

require("user.plugins.autopairs")
require("user.plugins.treesitter")
-- require("user.plugins.lsp.null-ls")

require("user.plugins.bufferline")

require("user.plugins.nvim-tmux-navigation")

require("user.plugins.whichkey")
-- require("user.project")

-- require "user.cmp"
-- require "user.gitsigns"
-- require "user.toggleterm"
-- require "user.indentline"
-- require "user.autocommands"
