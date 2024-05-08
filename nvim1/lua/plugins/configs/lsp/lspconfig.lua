local lspconfig = require("lspconfig")

--[[ local navic_lsp_status_ok, navic = pcall(require, "nvim-navic")
if not navic_lsp_status_ok then
	return
end ]]

local maps = vim.keymap.set
local keymap = vim.keymap

local cap = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("cmp_nvim_lsp").default_capabilities(cap)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- require("lspinstall").setup() -- important

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
	--[[ if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end ]]

	local opts_l = { silent = true, noremap = true }

	maps("n", "K", vim.lsp.buf.hover, opts_l)

	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>a", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
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
		enabled = true,
		prefix = "x", -- Could be '■', '▎', 'x'
	},
	float = {
		focus = true,
		focusable = true,
		style = "minimal",
		source = "always",
		border = "rounded",
		suffix = "",
		header = { "  Diagnosis" },
		prefix = function(_, _, _)
			return "  ", "String"
		end,
	},
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

--lspconfig.clangd.setup({
--	filetypes = { "c", "cpp", "objc", "objcpp" },
--	cmd = { "clangd", "--background-index", "--suggest-missing-includes", "--clang-tidy", "--header-insertion=iwyu" },
--	single_file_support = true,
--
--	root_dir = lspconfig.util.root_pattern(
--		".clangd",
--		".clang-tidy",
--		".clang-format",
--		"compile_commands.json",
--		"configure.ac",
--		".git"
--	),
--	on_attach = on_attach,
--	capabilities = capabilities,
--	init_options = {
--		clangdFileStatus = true,
--	},
--	flags = {
--		debounce_text_changes = 500,
--	},
--})

lspconfig.bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 500,
	},
})

--lspconfig.hls.setup({
--	on_attach = on_attach,
--	capabilities = capabilities,
--	flags = {
--		debounce_text_changes = 500,
--	},
--})
--
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
	rootPatterns = "fladdke.nix",
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
	on_atsettings = {
		css = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
		scss = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
		less = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
	},
	tach = on_attach,
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
		"ts",
		"go",
	},
	flags = {
		debounce_text_changes = 500,
	},
})

lspconfig.htmx.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = {
		"gohtml",
		"html",
		"javascript",
		"typescript",
	},
})

lspconfig.html.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = {
		"html",
		"gohtml",
		"css",
		"javascript",
		"typescript",
	},
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
	filetypes = {
		"go",
		"gohtml",
		"html",
	},
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
		"rust-analyzer",
	},
	filetypes = { "rust" },
	-- root = util.root_pattern("Cargo.toml"),
})

local stat, rustools = pcall(require, "rust-tools")
if not stat then
	print("unable to find rust-tools")
	return
end

rustools.setup({

	tools = {

		autoSetHints = true,
		hover_actions = { border = false },
	},
	inlay_hints = {
		auto = true,
		show_parameter_hints = false,
		parameter_hints_prefix = "",
		other_hints_prefix = "",
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

lspconfig.templ.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "templ", "lsp", "go" },
	filetypes = {
		"templ",
	},
})

--[[ lspconfig.sqlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
}) ]]

--[[ lspconfig.sqlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
}) ]]

--[[ require("roslyn").setup({
    dotnet_cmd = "dotnet",           -- this is the default
    roslyn_version = "4.8.0-3.23475.7", -- this is the default
    on_attach = on_attach,
    capabilities = capabilities,
}) ]]
