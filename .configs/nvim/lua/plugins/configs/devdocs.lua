local statusOK, dev = pcall(require, "nvim-devdocs")
if not statusOK then
    return
end

dev.setup({
    dir_path = vim.fn.stdpath("data") .. "/devdocs", -- installation directory
    telescope = {},                               -- passed to the telescope picker
    float_win = {                                 -- passed to nvim_open_win(), see :h api-floatwin
        relative = "editor",
        height = 100,
        width = 200,
        border = "rounded",
    },
    wrap = false,              -- text wrap, only applies to floating window
    previewer_cmd = "glow",    -- for example: "glow"
    cmd_args = { "dark" },     -- example using glow: { "-s", "dark", "-w", "80" }
    cmd_ignore = {},           -- ignore cmd rendering for the listed docs
    picker_cmd = false,        -- use cmd previewer in picker preview
    picker_cmd_args = { "dark" }, -- example using glow: { "-s", "dark", "-w", "50" }
    mappings = {               -- keymaps for the doc buffer
        open_in_browser = "",
    },
    after_open = function(bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Esc>", ":close<CR>", {})
    end,
})
