local lspconfig = require("lspconfig")

local keymap = vim.keymap
local cap = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("cmp_nvim_lsp").default_capabilities(cap)
capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

local on_attach = function(client, bufnr)
    client.server_capabilities.documentSymbolProvider = true
    if
        client.server_capabilities.documentFormattingProvider
        or client.server_capabilities.documentRangeFormattingProvider
    then
        local group = vim.api.nvim_create_augroup("lsp_format_onsave", { clear = false })
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ timeout_ms = 2000 })
            end,
            desc = "Format using lsp/null-ls on save.",
            group = group,
        })
    end

    local maps = vim.keymap.set
    local opts_l = { silent = true, noremap = true }

    maps("n", "K", vim.lsp.buf.hover, opts_l)

    local opts = { noremap = true, silent = true, buffer = bufnr }

    keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)       -- got to declaration
    keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)             -- see definition and make edits in window
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)    -- go to implementation
    keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)     -- go to implementation
    keymap.set("n", "<leader>a", "<cmd>Lspsaga code_action<CR>", opts)          -- see available code actions
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)              -- smart rename
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
    keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)        -- jump to previous diagnostic in buffer
    keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)        -- jump to next diagnostic in buffer
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)                    -- show documentation for what is under cursor
    keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)              -- see outline on right hand side
end

lspconfig.settings = {
    snippets = {
        history = true,
        updateevents = "TextChanged,TextChangedI",
    },
    flags = {
        debounce_text_changes = 200,
    },
}

vim.diagnostic.config({
    virtual_text = {
        prefix = " ", -- Could be '■', '▎', 'x'
    },
    float = {
        focus = true,
        focusable = false,
        style = "minimal",
        source = "always",
        border = "rounded",
        suffix = "",
        header = { "  Diagnosis" },
        prefix = function(_, _, _)
            return "  ", "String"
        end,
    },
})

local signs = { Error = " ", Warn = "", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    opts = {
        servers = {
            -- Ensure mason installs the server
            clangd = {
                keys = {
                    { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
                },
                root_dir = function(fname)
                    return require("lspconfig.util").root_pattern(
                        "Makefile",
                        "configure.ac",
                        "configure.in",
                        "config.h.in",
                        "meson.build",
                        "meson_options.txt",
                        "build.ninja"
                    )(fname) or require("lspconfig.util").root_pattern(
                        "compile_commands.json",
                        "compile_flags.txt"
                    )(fname) or require("lspconfig.util").find_git_ancestor(fname)
                end,
                capabilities = {
                    offsetEncoding = { "utf-16" },
                },
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
            },
        },
        setup = {
            clangd = function(_, opts)
                local clangd_ext_opts = require("lazyvim.util").opts("clangd_extensions.nvim")
                require("clangd_extensions").setup(
                    vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts })
                )
                return true
            end,
        },
    },
    flags = {
        debounce_text_changes = 500,
    },
})
lspconfig.bashls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 500,
    },
})

lspconfig.zls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 500,
    },
})

-- lspconfig.asm_lsp.setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
-- })

-- lspconfig.ocamllsp.setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
-- })

-- lspconfig.pyright.setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
-- })

lspconfig.nil_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    command = "nil",
    rootPatterns = "flake.nix",
    ftpattern = { "nix" },
    flags = {
        debounce_text_changes = 500,
    },
})

lspconfig.tsserver.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 500,
    },
})

lspconfig.cssls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 500,
    },
})

--[[ lspconfig.omnisharp.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    rootdir = function(fname)
        local primary = require("lspconfig").util.root_pattern("*.sln")(fname)
        local fallback = require("lspconfig").util.root_pattern("*.sln")(fname)
    end,
})

-- local dotnet_place = "/home/kenzo/.nix-profile/bin/dotnet"
lspconfig.csharp_ls.setup({
    -- cmd = { dotnet_place },
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function(startpath)
        return lspconfig.util.root_pattern("*.sln")(startpath)
            or lspconfig.util.root_pattern("*.csproj")(startpath)
            or lspconfig.util.root_pattern("*.fsproj")(startpath)
            or lspconfig.util.root_pattern(".git")(startpath)
    end,
}) ]]

lspconfig.eslint.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {
        "html",
        "css",
        "javascript",
        "js",
    },
    flags = {
        debounce_text_changes = 500,
    },
})

--[[ lspconfig.htmx.setup({
    capabilities = capabilities,
    on_attach = on_attach,
}) ]]

lspconfig.html.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        css = {
            lint = {
                validProperties = {},
            },
        },
    },
    flags = {
        debounce_text_changes = 500,
    },
})

lspconfig.gopls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
--
-- configure lua server (with special settings)
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    maxPreload = 10000,
    preloadFileSize = 1000,
    settings = { -- custom settings for lua
        Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
                enabled = true,
                globals = { "vim" },
            },
            workspace = {
                -- make language server aware of runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
})

lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        "rustup",
        "run",
        "stable",
        "rust-analyzer",
    },
})

local stat, rustools = pcall(require, "rust-tools")
if not stat then
    print("unable to find rust-tools")
    return
end

rustools.setup({

    tools = {
        autoSetHints = false,
        hover_actions = { border = false },
        cache = true,
    },
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {
            "rustup",
            "run",
            "stable",
            "rust-analyzer",
        },

        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    runBuildScripts = true,
                },
                diagnostics = {
                    experimental = true,
                },
            },
        },
    },
})

--[[ require("roslyn").setup({
    dotnet_cmd = "dotnet",           -- this is the default
    roslyn_version = "4.8.0-3.23475.7", -- this is the default
    on_attach = on_attach,
    capabilities = capabilities,
}) ]]
