return {

    -- File explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        module = "neo-tree",
        cmd = "Neotree",
        dependencies = { { "MunifTanjim/nui.nvim", module = "nui" }, "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.configs.neo-tree")
        end,
    },
    {
        "bennypowers/nvim-regexplainer",
        config = function()
            require("plugins.configs.regexer")
        end,
        requires = {
            "nvim-treesitter/nvim-treesitter",
            "MunifTanjim/nui.nvim",
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            --            local hooks = require("ibl.hooks"),
            --            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level),
            --            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level),
            indent = {
                char = "▏", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
            },
            scope = {
                show_start = false,
                show_end = false,
            },
        },
    },
    -- inactive
    -- Lua
    {
        "folke/twilight.nvim",
        opts = {
            dimming = {
                alpha = 0.25, -- amount of dimming
                -- we try to get the foreground from the highlight groups or fallback color
                color = { "Normal", "#ffffff" },
                term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
                inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
            },
            context = 10, -- amount of lines we will try to show around the current line
            treesitter = true, -- use treesitter when available for the filetype
            -- treesitter is used to automatically expand the visible text,
            -- but you can further control the types of nodes that should always be fully expanded
            expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
                "function",
                "method",
                "table",
                "if_statement",
            },
            exclude = {}, -- exclude these filetypes
        },
    },
    -- zenmode
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
                -- height and width can be:
                -- * an absolute number of cells when > 1
                -- * a percentage of the width / height of the editor when <= 1
                -- * a function that returns the width or the height
                width = 120, -- width of the Zen window
                height = 1, -- height of the Zen window
                -- by default, no options are changed for the Zen window
                -- uncomment any of the options below, or add other vim.wo options you want to apply
                options = {
                    -- signcolumn = "no", -- disable signcolumn
                    -- number = , -- disable number column
                    relativenumber = true, -- disable relative numbers
                    cursorline = false, -- disable cursorline

                    cursorcolumn = false, -- disable cursor column
                    -- foldcolumn = "0", -- disable fold column
                    -- list = false, -- disable whitespace characters
                },
            },
            toggle = {
                window = {
                    width = 0.85, -- width will be 85% of the editor width
                },
            },
            plugins = {
                -- disable some global vim options (vim.o...)
                -- comment the lines to not apply the options
                options = {
                    enabled = true,
                    ruler = false, -- disables the ruler text in the cmd line area
                    showcmd = false, -- disables the command in the last line of the screen
                    -- you may turn on/off statusline in zen mode by setting 'laststatus'
                    -- statusline will be shown only if 'laststatus' == 3
                    laststatus = 0, -- turn off the statusline in zen mode
                },
                twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
                gitsigns = { enabled = false }, -- disables git signs
                tmux = { enabled = false }, -- disables the tmux statusline
                -- this will change the font size on kitty when in zen mode
                -- to make this work, you need to set the following kitty options:
                -- - allow_remote_control socket-only
                -- - listen_on unix:/tmp/kitty
                kitty = {
                    enabled = false,
                    font = "+4", -- font size increment
                },
                -- this will change the font size on alacritty when in zen mode
                -- requires  Alacritty Version 0.10.0 or higher
                -- uses `alacritty msg` subcommand to change font size
                alacritty = {
                    enabled = true,
                    font = "10.5", -- font size
                },
                -- this will change the font size on wezterm when in zen mode
                -- See alse also the Plugins/Wezterm section in this projects README
                wezterm = {
                    enabled = false,
                    -- can be either an absolute font size or the number of incremental steps
                    font = "+4", -- (10% increase per step)
                },
            },
            -- callback where you can add custom code when the Zen window opens
            on_open = function(win) end,
            -- callback where you can add custom code when the Zen window closes
            on_close = function() end,
        },
    },
    ------------------------------minii----------------------------
    {
        "echasnovski/mini.indentscope",
        version = false,
        -- enabled = false,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            draw = {
                delay = 100,
            },
            mappings = {
                -- Textobjects
                object_scope = "ii",
                object_scope_with_border = "ai",

                -- Motions (jump to respective border line; if not present - body line)
                goto_top = "[i",
                goto_bottom = "]i",
            },
            symbol = "▏", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
            options = {
                border = "both",
                indent_at_cursor = true,
                indent_at_scope = false,
                try_as_border = false,
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = false
                end,
            })
        end,
    },

    {
        "PHSix/faster.nvim",
        event = { "VimEnter *" },
        config = function()
            vim.api.nvim_set_keymap("n", "j", "<Plug>(faster_move_j)", { noremap = false, silent = true })
            vim.api.nvim_set_keymap("n", "k", "<Plug>(faster_move_k)", { noremap = false, silent = true })
        end,
    },

    {
        "stevearc/oil.nvim",
        -- Optional dependencies
        config = function()
            require("plugins.configs.oil")
        end,
    },

    {
        "phaazon/hop.nvim",
        branch = "v2", -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require("plugins.configs.hop")
        end,
    },

    -- fugitive for the nerds
    {
        "tpope/vim-fugitive",
    },

    {
        "kevinhwang91/nvim-ufo",
        event = "BufReadPost",
        lazy = true,
        dependencies = "kevinhwang91/promise-async",
        config = function()
            require("plugins.configs.ufo")
        end,
    },

    {
        "echasnovski/mini.animate",
        enabled = false,
        event = "VeryLazy",
        config = function(_, _)
            require("mini.animate").setup()
        end,
    },

    --------------------------mini end--------------------------------

    -- Coloscheme
    {
        "ellisonleao/gruvbox.nvim",
        opts = {
            terminal_colors = true, -- add neovim terminal colors
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = false,
                emphasis = false,
                comments = false,
                operators = false,
            },
            -- contrast = "hard", -- can be "hard", "soft" or empty string
            transparent_mode = true,
            palette_overrides = {
                bright_green = "#d1b000",
                bright_blue = "#E6BE8A",
                bright_red = "#ffdb58",
            },
        },
    },
    -- Statusline

    {
        "nvim-lualine/lualine.nvim",

        config = function()
            require("plugins.configs.lualine")
        end,
    },

    -- lazy.nvim
    {
        "m4xshen/hardtime.nvim",
        enabled = false,
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.configs.hardtime")
        end,
    },

    {
        "luckasRanarison/nvim-devdocs",

        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("plugins.configs.devdocs")
        end,
    },

    {
        "tomiis4/Hypersonic.nvim",
        event = "CmdlineEnter",
        cmd = "Hypersonic",
        config = function()
            require("plugins.configs.hyper")
        end,
    },

    -- {
    --     "Bekaboo/dropbar.nvim",
    --     enabled = false, --------------disabled currently not supported
    --
    --     dependencies = {
    --         "nvim-telescope/telescope-fzf-native.nvim",
    --     },
    --     config = function()
    --         require("plugins.configs.dropbar")
    --     end,
    -- },

    {
        "folke/which-key.nvim",
        config = function()
            require("plugins.configs.whichkey")
        end,
    },

    -- Tabs
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("plugins.configs.bufferline")
        end,
    },
    {
        "tiagovla/scope.nvim",
        config = true,
    },

    -- Surround words with: "({[
    {
        "kylechui/nvim-surround",
        config = function()
            require("plugins.configs.surround")
        end,
    },

    -- Comment stuff
    {
        "numToStr/Comment.nvim",
        config = function()
            require("plugins.configs.comment")
        end,
    },

    -- Icons
    {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.configs.nvim-webdev-icons")
        end,
    },

    -- Telescope, Fzfinder
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("plugins.configs.telescope")
        end,
    },
    { "nvim-telescope/telescope-media-files.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim" },
    --	{
    --		"ahmedkhalf/project.nvim",
    --		config = function()
    --			require("plugins.configs.project")
    --		end,
    --	},
    { "ibhagwan/fzf-lua" },

    -- Dashboard Init
    {
        "goolord/alpha-nvim",
        config = function()
            require("plugins.configs.alpha")
        end,
    },

    -------------------- Auto completions-----------------------
    { "hrsh7th/cmp-buffer" }, -- buffer completions
    { "hrsh7th/cmp-path" }, -- path completions
    { "hrsh7th/cmp-cmdline" }, -- cmdline completions
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "f3fora/cmp-spell" },
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("plugins.configs.lsp.cmp")
        end,
    },
    -- Shippets
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("plugins.configs.lsp.luasnip")
        end,
    },
    { "saadparwaiz1/cmp_luasnip" },
    { "rafamadriz/friendly-snippets" },

    -- Manage and Install LSP servers
    { "williamboman/mason-lspconfig" },
    {
        "williamboman/mason.nvim",
        config = function()
            require("plugins.configs.lsp.mason")
        end,
    },

    --	{
    --		"jay-babu/mason-null-ls.nvim",
    --		event = { "BufReadPre", "BufNewFile" },
    --		dependencies = {
    --			"williamboman/mason.nvim",
    --			"jose-elias-alvarez/null-ls.nvim",
    --		},
    --		config = function()
    --			require("plugins.configs.lsp.null-ls") -- require your null-ls config here (example below)
    --		end,
    --	},

    ------------------- Config for LSP Servers----------------------
    {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" },
        },
        config = function()
            require("plugins.configs.lsp.lspsaga")
        end,
    },
    { "onsails/lspkind.nvim" },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            require("plugins.configs.lsp.lspconfig")
        end,
        opts = { lsp = { auto_attach = true } },
    },

    --------------- conform.nvim formatter---------------------
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.configs.lsp.conform")
        end,
    },
    -------------------Linting--------------------------------
    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                javascript = { "eslint_d" },
                html = { "eslint_d" },
                css = { "eslint_d" },
                typescript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                svelte = { "eslint_d" },
                python = { "pylint" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })

            vim.keymap.set("n", "<leader>l", function()
                lint.try_lint()
            end, { desc = "Trigger linting for current file" })
        end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.install").update({ with_sync = true })
            require("plugins.configs.treesitter")
        end,
    },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    { "rush-rs/tree-sitter-asm" },
    { "p00f/nvim-ts-rainbow" },
    { "nvim-treesitter/playground" },

    -- Auto closing
    {
        "windwp/nvim-autopairs",
        config = function()
            require("plugins.configs.autopairs")
        end,
    },
    { "windwp/nvim-ts-autotag" },

    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        enabled = false,
        config = function()
            require("plugins.configs.gitsigns")
        end,
    },
    {
        "ruifm/gitlinker.nvim",
        config = function()
            require("plugins.configs.gitlinker")
        end,
    },
    { "mattn/vim-gist" },
    { "mattn/webapi-vim" },

    -- Color
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("plugins.configs.colorize")
        end,
    },

    -- Sessions TODO: Check the keybinds
    {
        "rmagatti/auto-session",
        enabled = false,
        config = function()
            require("plugins.configs.auto-session")
        end,
    },

    -- UI
    {
        "stevearc/dressing.nvim",
        config = function()
            require("plugins.configs.dressing")
        end,
    },
    {
        "SmiteshP/nvim-navic",
        lazy = true,
        init = function()
            vim.g.navic_silence = true
            local on_attach = function(client, buffer)
                if client.supports_method("textDocument/documentSymbol") then
                    require("nvim-navic").attach(client, buffer)
                end
            end
        end,
        config = function()
            require("plugins.configs.navic")
        end,
        dependencies = { "neovim/nvim-lspconfig" },
    },
    { "kshenoy/vim-signature" },

    -- Notification
    {
        "rcarriga/nvim-notify",
        config = function()
            require("plugins.configs.notify")
        end,
    },

    -- Smooth scroll
    {
        "karb94/neoscroll.nvim",
        config = function()
            require("plugins.configs.neoscroll")
        end,
    },

    -- Match up blocks of code TODO: Check keybinds
    {
        "andymass/vim-matchup",
        config = function()
            require("plugins.configs.matchup")
        end,
    },

    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        config = function()
            require("plugins.configs.harpoon")
        end,
    },

    -- Todo Comment TODO: Check the keybinds
    {
        "folke/todo-comments.nvim",
        config = function()
            require("plugins.configs.todo-comments")
        end,
    },

    -- toggle Term TODO: Check the keybinds
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("plugins.configs.toggle-term")
        end,
    },

    -- Impatient optimize the startup time
    {
        "lewis6991/impatient.nvim",
        config = function()
            _G.__luacache_config = {
                chunks = {
                    enable = true,
                    path = vim.fn.stdpath("cache") .. "/luacache_chunks",
                },
                modpaths = {
                    enable = true,
                    path = vim.fn.stdpath("cache") .. "/luacache_modpaths",
                },
            }
            require("impatient")
        end,
    },

    -- Rust
    {
        "simrat39/rust-tools.nvim",
        enabled = false,
        config = function()
            require("plugins.configs.personalDevelopmentEnv.rust-tools")
        end,
    },
    { "Saecki/crates.nvim" },

    -- Spectre: Better find and replace
    {
        "windwp/nvim-spectre",
        config = function()
            require("plugins.configs.spectre")
        end,
    },

    -- Diffview
    -- {
    -- 	"sindrets/diffview.nvim",
    -- 	config = true,
    -- },

    -- {
    --     "ray-x/go.nvim",
    --     config = true,
    -- },
    -- { "ray-x/guihua.lua" },

    -- {
    --     "folke/trouble.nvim",
    --     cmd = { "TroubleToggle", "Trouble" },
    -- },
    {
        "dgagn/diagflow.nvim",
        -- event = 'LspAttach', This is what I use personnally and it works great
        opts = {},
        config = function()
            require("plugins.configs.diagflow")
        end,
    },

    -- Ui Noice
    -- experimental
    {
        "folke/noice.nvim",
        enabled = false,
        event = "VeryLazy",
        opts = {
            presets = {
                command_palette = false,
            },
        },
    },

    {
        "krady21/compiler-explorer.nvim",
    },
    {
        "Jezda1337/nvim-html-css",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("plugins.configs.personalDevelopmentEnv.css-intel")
        end,
    },
    {
        "p00f/clangd_extensions.nvim",
        config = function()
            require("plugins.configs.personalDevelopmentEnv.clang")
        end,
    },
    {
        "lewis6991/hover.nvim",
        config = function()
            require("hover").setup({
                init = function()
                    -- Require providers
                    require("hover.providers.lsp")
                    -- require('hover.providers.gh')
                    -- require('hover.providers.gh_user')
                    -- require('hover.providers.jira')
                    -- require('hover.providers.man')
                    -- require('hover.providers.dictionary')
                end,
                preview_opts = {
                    border = nil,
                },
                preview_window = false,
                title = true,
            })

            vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
            vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
        end,
    },
    --[[
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui" },
			{ "theHamsta/nvim-dap-virtual-text" },
			{ "nvim-telescope/telescope-dap.nvim" },
			{ "jbyuki/one-small-step-for-vimkind" },
		},
        -- stylua: ignore
        keys = {
            { "<leader>dR", function() require("dap").run_to_cursor() end, desc = "Run to Cursor", },
            { "<leader>dE", function() require("dapui").eval(vim.fn.input "[Expression] > ") end, desc = "Evaluate Input", },
            { "<leader>dC", function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end, desc = "Conditional Breakpoint", },
            { "<leader>dU", function() require("dapui").toggle() end, desc = "Toggle UI", },
            { "<leader>db", function() require("dap").step_back() end, desc = "Step Back", },
            { "<leader>dc", function() require("dap").continue() end, desc = "Continue", },
            { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect", },
            { "<leader>de", function() require("dapui").eval() end, mode = {"n", "v"}, desc = "Evaluate", },
            { "<leader>dg", function() require("dap").session() end, desc = "Get Session", },
            { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "Hover Variables", },
            { "<leader>dS", function() require("dap.ui.widgets").scopes() end, desc = "Scopes", },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into", },
            { "<leader>do", function() require("dap").step_over() end, desc = "Step Over", },
            { "<leader>dp", function() require("dap").pause.toggle() end, desc = "Pause", },
            { "<leader>dq", function() require("dap").close() end, desc = "Quit", },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL", },
            { "<leader>ds", function() require("dap").continue() end, desc = "Start", },
            { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint", },
            { "<leader>dx", function() require("dap").terminate() end, desc = "Terminate", },
            { "<leader>du", function() require("dap").step_out() end, desc = "Step Out", },
        },
		opts = {
			setup = {
				osv = function(_, _)
					require("plugins.configs.debugging.go").setup()
				end,
			},
		},
		config = function(plugin, opts)
			require("nvim-dap-virtual-text").setup({
				commented = true,
			})

			local dap, dapui = require("dap"), require("dapui")
			dapui.setup({})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- set up debugger
			for k, _ in pairs(opts.setup) do
				opts.setup[k](plugin, opts)
			end
		end,
	}, ]]
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
        },
        config = function()
            require("plugins.configs.personalDevelopmentEnv.neotest")
        end,
        opts = {
            -- Can be a list of adapters like what neotest expects,
            -- or a list of adapter names,
            -- or a table of adapter names, mapped to adapter configs.
            -- The adapter will then be automatically loaded with the config.
            adapters = {},
            -- Example for loading neotest-go with a custom config
            -- adapters = {
            --   ["neotest-go"] = {
            --     args = { "-tags=integration" },
            --   },
            -- },
            status = { virtual_text = true },
            output = { open_on_run = true },
        },
    },
    {
        "OmniSharp/omnisharp-vim",
        config = function()
            require("plugins.configs.lsp.omnisharp")
        end,
    },
}
