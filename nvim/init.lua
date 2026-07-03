vim.cmd('let g:python3_host_prog = "~/.config/nvim_python/.venv/bin/python"')

-- core (keymaps sets <leader>, which must happen before lazy loads plugins)
require("user.core.options")
require("user.core.keymaps")
require("user.core.diagnostics")

-- plugin manager + specs (replaces packer/plugins-setup)
require("user.lazy")
