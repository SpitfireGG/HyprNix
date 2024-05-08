--zy import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
	return
end

saga.setup({
	move_in_saga = { prev = "<C-p>", next = "<C-n>" },
	finder_action_keys = {
		open = "<CR>",
	},
	definition_action_keys = {
		edit = "<CR>",
	},
	finder = {
		max_height = 0.5,
		force_max_height = false,
		keys = {
			jump_to = "p",
			edit = { "o", "<CR>" },
			vsplit = "s",
			split = "i",
			tabe = "t",
			tabnew = "r",
			quit = { "q", "<ESC>" },
			close_in_preview = "<ESC>",
		},
	},
	definition = {
		edit = "<C-c>o",
		vsplit = "<C-c>v",
		split = "<C-c>i",
		tabe = "<C-c>t",
		quit = "q",
	},
	code_action = {
		num_shortcut = true,
		show_server_name = false,
		extend_gitsigns = true,
		keys = {
			quit = "q",
			exec = "<CR>",
		},
	},
	lightbulb = {
		enable = true,
		enable_in_insert = false,
		sign = true,
		sign_priority = 40,
		virtual_text = false,
	},
	diagnostic = {
		enable = true,
		on_insert = false,
		on_insert_follow = false,
		insert_winblend = 0.5,
		show_virt_line = true,
		show_code_action = true,
		show_source = true,
		jump_num_shortcut = true,
		max_width = 0.10,
		custom_fix = nil,
		custom_msg = nil,
		text_hl_follow = false,
		border_follow = true,
		keys = {
			exec_action = "o",
			quit = "q",
			go_action = "g",
		},
	},
	symbol_in_winbar = {
		enable = true,
		separator = " ❭ ",
		show_file = true,
		hide_keyword = false,
		folder_level = 0,
		respect_root = true,
		color_mode = true,
	},

	implement = {
		enable = true,
		sign = true,
		virtual_text = true,
		priority = 100,
	},
})
