local options = {
	backup = false, -- creates a backup file
	clipboard = "", -- denied neovim to access the system clipboard
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 0, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 4, -- the number of spaces inserted for each indentation
	tabstop = 4, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	laststatus = 4,
	showcmd = false,
	ruler = false,
	relativenumber = true, -- set relative numbered lines
	numberwidth = 2, -- set number column width to 2 {default 4}
	wrap = false, -- set signcolumn=number display lines as one long line
	scrolloff = 8, -- is one of my fav
  signcolumn = "yes",
	sidescrolloff = 8,
	backspace = "indent,eol,start",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.g.gitblame_enabled = 0



-- Enable signcolumn for Go files
vim.cmd[[
  augroup GoSignColumn
    autocmd!
    autocmd FileType go setlocal signcolumn=no
  augroup END
]]


-- Disable signcolumn for other filetypes
vim.cmd[[
  augroup OtherFileTypes
    autocmd!
    autocmd FileType python,typescript setlocal signcolumn=yes
  augroup END
]]

