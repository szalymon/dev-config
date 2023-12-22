-- import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
	print("Failed to load lspsaga")
	print(saga_status)
	return
end

saga.setup({
	-- keybinds for navigation in lspsaga window
	scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
	-- use enter to open file with definition preview
	definition = {
		-- edit = "<CR>",
		keys = {
			edit = "<CR>",
		},
	},
	ui = {
		colors = {
			normal_bg = "#022746",
		},
	},
})
