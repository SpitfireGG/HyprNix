local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	print("bufferline not loaded")
	return
end

bufferline.setup({
	highlights = {
		fill = {
			fg = "#b8bb26",
			bg = "#0A0E14",
		},
		background = {
			fg = "#f9f5d7",
			-- bg = "#0A0E14",
		},
		tab = {
			fg = "#fe8019",
			--bg = "#0A0E14",
		},
		tab_selected = {
			fg = "#fe8019",
			bg = "#141e30",
		},
		buffer_selected = { italic = false, bold = false },
		diagnostic_selected = { italic = false },
		hint_selected = { italic = false },
		pick_selected = { italic = false },
		pick_visible = { italic = false },
		pick = { italic = false },
	},
	options = {
		mode = "buffer",
		numbers = "yes",
		close_command = "bd! %d",
		right_mouse_command = "bd! %d",
		left_mouse_command = "buffer %d",
		maximum_padding = 0,
		style_preset = require("bufferline").style_preset.no_italic,

		indicator = {
			icon = "▎",
			style = "",
		},
		indicator_icon = "▎",
		buffer_close_icon = " ",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",

		max_name_length = 30,
		max_prefix_length = 30,
		tab_size = 18,
		diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
		diagnostics_update_in_insert = false,
		offsets = {
			{ filetype = "vista", text = "Tags", padding = 1 },
			{ filetype = "neo-tree", text = "Explorer", padding = 1 },
		},
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		persist_buffer_sort = true,
		separator_style = "",
		enforce_regular_tabs = true,
		always_show_bufferline = true,
	},
})
