local statusOK, hop = pcall(require, "hop")
if not statusOK then
	return
end

local keymap = vim.keymap
hop.setup({
	case_insensitive = true,
	char2_fallback_key = "<CR>",
	quit_key = "<Esc>",
})

keymap.set({ "n", "v", "o" }, "f", "", {
	silent = true,
	noremap = true,
	callback = function()
		hop.hint_char2()
	end,
	desc = "nvim-hop char2",
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.cmd([[
      hi HopNextKey cterm=bold ctermfg=176 gui=bold guibg=#C0bd90 guifg=#ffffff
      hi HopNextKey1 cterm=bold ctermfg=176 gui=bold guibg=#C0bd90 guifg=#ffffff
      hi HopNextKey2 cterm=bold ctermfg=176 gui=bold guibg=#C0bd90 guifg=#ffffff
    ]])
	end,
})
