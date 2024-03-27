local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not lspkind_status_ok then
    return
end

local compare = require("cmp.config.compare")

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local has_words_before = function()
    local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local icons = require("plugins.configs.icons")

local kind_icons = icons.kind

vim.opt.completeopt = "menu,menuone,noinsert,preview"

--[[ local function my_source(context)
	-- Check if the cursor is inside a string
	local line = vim.api.nvim_get_current_line()
	local start, finish = string.find(line, "[\"'][^\"']*[\"']")
	if start and finish and context.offset >= start and context.offset <= finish then
		-- If the cursor is inside a string, return an empty table
		return { items = {} }
	else
		-- Otherwise, return the completion items from the 'nvim_lsp' source
		return cmp.source.complete(context, "nvim_lsp")
	end
end ]]

vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-c>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif check_backspace() then
                cmp.complete()
                fallback()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    }),

    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            if entry.source.name == "html-css" then
                vim_item.menu = entry.completion_item.menu
            end
            local kind = lspkind.cmp_format({
                symbol_map = { Snippet = " ", Keyword = "󰋱 " },
                preset = "codicons",
                maxwidth = 80,
            })(entry, vim_item)
            local strings = vim.split(vim_item.kind, "%s+", { trimempty = true })
            kind.kind = " " .. string.format("%s │", strings[1], strings[2]) .. " "
            return kind
        end,
    },
    sources = {
        sources = {
            { name = "nvim_lsp_signature_help" },
        },
        { name = "path" },
        { name = "nvim_lsp", keyword_length = 3 },
        { name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
        { name = "luasnip",  keyword_length = 3 },
        { name = "buffer",   keyword_length = 1 },
        { name = "calc" }, -- source for math calculation
    },
    sorting = {
        comparators = {
            require("clangd_extensions.cmp_scores"),
            compare.offset,
            compare.exact,
            compare.recently_used,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
        },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        documentation = {
            border = "rounded",
            winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
        },
        completion = {
            border = "rounded",
            winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
        },
    },
    experimental = {
        ghost_text = {
            enable = true,
        },
    },
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        {
            name = "cmdline",
            option = {
                ignore_cmds = { "Man", "!" },
            },
        },
    }),
})
