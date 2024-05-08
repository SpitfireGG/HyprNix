local function lspSymbol(name, icon)
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")



-- vim.lsp.handlers["textDocument/diagnostic"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_diagnostic, {
--         -- Enable underline, use default values
--         underline = true,
--         -- Enable virtual text, override spacing to 4
--         virtual_text = {
--             spacing = 4,
--         },
--         -- Use a function to dynamically turn signs off
--         -- and on, using buffer local variables
--         signs = function(namespace, bufnr)
--             return vim.b[bufnr].show_signs == true
--         end,
--         -- Disable a feature
--         update_in_insert = false,
--     }
-- )

-- vim.lsp.handlers["textDocument/diagnostic"] = vim.lsp.with(
-- vim.diagnostic.on_diagnostic({
--     virtual_text = {
--         enabled = true,
--         -- source = "always",  -- Or "if_many"
--         prefix = '●', -- Could be '■', '▎', 'x'
--     },
--     -- virtual_text = true,
--     -- signs = true,
--     -- underline = true,
--     -- update_in_insert = false,
--     -- severity_sort = true,
--     float = {
--         focus = true,
--         focusable = false,
--         style = "minimal",
--         source = "always",
--         border = "rounded",
--         suffix = "",
--         header = { "  Diagnosis" },
--         prefix = function(_, _, _)
--             return "  ", "String"
--         end,
--     },
-- })
--


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
    focusable = false,
    relative = "cursor",
})

-- suppress error messages from lang servers
vim.notify = function(msg, log_level)
    if msg:match "exit code" then
        return
    end
    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
        vim.api.nvim_echo({ { msg } }, true, {})
    end
end

-- Borders for LspInfo winodw
local win = require "lspconfig.ui.windows"
local _default_opts = win.default_opts

win.default_opts = function(options)
    local opts = _default_opts(options)
    opts.border = "single"
    return opts
end
