local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	return
end

local lsp_status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not lsp_status_ok then
	return
end

local config = {
	ui = {
		icons = {
			package_pending = "󰁇 ",
			package_installed = " ",
			package_uninstalled = " ",
		},
	},
}

mason.setup()

mason_lsp.setup({
	ensure_installed = {
		"gopls",
		"clangd",
		"bashls",
		"nil_ls",
		"lua_ls",
		"rust_analyzer",
		"tsserver",
	},
	automatic_installation = true,
})
