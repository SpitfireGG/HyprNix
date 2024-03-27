local statusOk, hypr = pcall(require, "hypersonic")
if not statusOk then
	return
end

hypr.setup({
	border = "rounded",
	---@type number 0-100
	winblend = 0,
	---@type boolean
	add_padding = true,
	---@type string
	hl_group = "Keyword",
	---@type string
	wrapping = '"',
	---@type boolean
	enable_cmdline = false,
})
