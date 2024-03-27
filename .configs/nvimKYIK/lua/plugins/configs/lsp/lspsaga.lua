--zy import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
    return
end

saga.setup({
    --symbols_in_winbar = { enable = true },
    -- keybinds for navigation in lspsaga window
    move_in_saga = { prev = "<C-p>", next = "<C-n>" },
    -- use enter to open file with finder
    finder_action_keys = {
        open = "<CR>",
    },
    -- use enter to open file with definition preview
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
    -- diagnostic = {
    --     enable = true,
    --     on_insert = false,
    --     on_insert_follow = false,
    --     insert_winblend = 0.10,
    --     show_virt_line = false,
    --     show_code_action = true,
    --     show_source = true,
    --     jump_num_shortcut = true,
    --     max_width = 0.7,
    --     custom_fix = nil,
    --     custom_msg = nil,
    --     text_hl_follow = false,
    --     border_follow = false,
    --     keys = {
    --         exec_action = "o",
    --         quit = "q",
    --         go_action = "g",
    --     },
    -- },
    symbol_in_winbar = {
        enable = true,
        separator = "  ",
        ignore_patterns = {},
        hide_keyword = false,
        show_file = true,
        folder_level = 1,
        respect_root = false,
        color_mode = true,
    },
    outline = {
        win_position = "right", -- window position
        win_width = 30,   --window width
        auto_preview = true, -- auto preview when cursor moved in outline window
        detail = true,    -- show detail
        auto_close = true,
        close_after_jump = false,
        layout = "float",
        max_height = 0.5,
        left_width = 0.3,
    },
    implement = {
        enable = false,
        sign = false,
        virtual_text = false,
        priority = 0,
    },
})
