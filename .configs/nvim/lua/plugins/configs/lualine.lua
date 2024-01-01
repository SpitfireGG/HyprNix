local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
    return
end

-- - stylua: ignore
local colors = {
    fg = "#B3B1AD",
    finger = nil,
    darkblue = "#0A0E14",
    violet = "#a9a1e1",
    magenta = "#fe8019",
    red = "#cc241d",
    black = "#0A0E14",
    bg = "#3C3334",
    gray = "#504945",
    white = "#f9f5d7",
    cyan = "#83a598",
    green = "#b8bb26",
    orange = "#fe8019",
    orange_1 = "#FF8F40",
    yellow = "#fabd2f",
    blue = "#50A1CE",
    grey = "#928374",
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

-- Config
local config = {
    options = {
        -- Disable sections and component separators
        component_separators = { left = " ", right = " " },
        section_separators = "",
        theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal = { c = { fg = colors.fg, bg = colors.finger } },
            --
            inactive = { c = { fg = colors.fg, bg = colors.darkblue } },
        },
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {
            { get_name, cond = is_active },
        },
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

ins_left({
    -- mode component
    "mode",
    color = function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colors.orange,
            i = colors.green,
            v = colors.blue,
            [""] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [""] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ["r?"] = colors.cyan,
            ["!"] = colors.red,
            t = colors.red,
        }
        return { fg = colors.bg, bg = mode_color[vim.fn.mode()], gui = "bold" }
    end,
    padding = { right = 1, left = 1 },
})

ins_left({
    "filename",
    icon = "🌊",
    cond = conditions.buffer_not_empty,
    color = { fg = colors.green, gui = "" },
    padding = { left = 3 },
})

ins_left({
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " " },
    diagnostics_color = {
        color_error = { fg = colors.grey },
        color_warn = { fg = colors.grey },
        color_info = { fg = colors.grey },
    },
    padding = { left = 2 },
})
--
ins_left({
    "diff",
    -- Is it me or the symbol for modified us really weird
    symbols = { added = " ", modified = " ", removed = " " },
    diff_color = {
        added = { fg = colors.grey },
        modified = { fg = colors.grey },
        removed = { fg = colors.grey },
    },
    cond = conditions.hide_in_width,
    padding = { left = 3 },
})
-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
    function()
        return "%="
    end,
})

ins_right({
    -- Lsp server name .
    function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = " lsp:",
    color = { fg = colors.cyan, gui = "" },
})
--
-- Add components to right sections
--
ins_right({ "location", color = { fg = colors.gray } })
ins_right({ "progress", color = { fg = colors.grey, gui = "bold" } })

ins_right({
    "fileformat",
    fmt = string.lower,
    icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
    color = { fg = colors.green, gui = "" },
})

ins_right({
    "branch",
    icon = "󰊢",
    color = { fg = colors.orange, gui = "" },
})

ins_right({
    function()
        return " "
    end,
    color = { fg = colors.blue },
    padding = { left = 1 },
})

-- Now don't forget to initialize lualine
lualine.setup(config)
