local statusOk, conform = pcall(require, "conform")
if not statusOk then
	return
end
conform.setup({
	formatters_by_ft = {
		-- "lua" = { "stylua" },
		go = { "gofumpt", "gofmt", "goimports" },
		rust = { "rust-analyzer", "rustfmt" },
		ocaml = { "ocamlformat" },
		bash = { "shfmt", "beautysh" },
		c = { "clang-format" },
		nix = { "nixfmt" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		lua = { "stylua" },
		python = { "isort", "black" },
		sql = { "sql-formatter" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		quiet = true,
		timeout_ms = 500,
	},
})

vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Format file or range (in visual mode)" })
