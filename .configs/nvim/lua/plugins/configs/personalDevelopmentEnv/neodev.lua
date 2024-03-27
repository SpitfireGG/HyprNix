require("neodev").setup({
	--required setups here;
})
local lspconfig = require("lspconfig")

-- example to setup lua_ls and enable call snippets
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})
