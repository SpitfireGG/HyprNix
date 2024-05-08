local kanagawa = require("kanagawa")

kanagawa.setup({

	-- Get the colors for the current theme

	-- Get the colors for a specific theme

	compile = false, -- enable compiling the colorscheme
	undercurl = true, -- enable undercurls
	commentStyle = { italic = false },
	functionStyle = {},
	keywordStyle = { italic = false },
	statementStyle = { bold = true },
	typeStyle = {},
	transparent = false, -- do not set background color
	globalStatus = true,
	dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	terminalColors = true, -- define vim.g.terminal_color_{0,17}

	colors = {
		palette = {
			-- change all usages of these colors
			sumiInk0 = "#000000",
			fujiWhite = "#FFFFFF",
		},
		theme = {
			-- change specific usages for a certain theme, or for all of them
			wave = {
				ui = {
					float = {
						bg = "none",
					},
				},
			},
			dragon = {
				syn = {
					parameter = "yellow",
				},
			},
			all = {
				ui = {
					bg_gutter = "none",
				},
			},
		},
	},
	overrides = function(colors) -- add/modify highlights
		local theme = colors.theme
		-- theme colors will update dynamically when you change theme!

		return {

			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },

			String = { fg = colors.palette.carpYellow, italic = false },
			SomePluginHl = { fg = colors.theme.syn.type, bold = true },

			Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
			PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
			PmenuSbar = { bg = theme.ui.bg_m1 },
			PmenuThumb = { bg = theme.ui.bg_p2 },
		}
	end,
	theme = "wave",
	background = { -- map the value of 'background' option to a theme
		dark = "wave", -- try "dragon" !
		light = "lotus",
	},
})
