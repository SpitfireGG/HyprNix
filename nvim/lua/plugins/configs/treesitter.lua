-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

-- configure treesitter
treesitter.setup({

	-- Install parsers synchronously (only applied to `ensure_installed`)
	-- ensure these language parsers are install
	{ import = "lazyvim.plugins.extra.lang.typescript" },
	ensure_installed = {
		"json",
		"javascript",
		"tsx",
		"yaml",
		"html",
		"css",
		"bash",
		"vim",
		"dockerfile",
		"gitignore",
		"rust",
		"toml",
	},
	indent = { enable = true },
  highlight = { enable = false },
})
