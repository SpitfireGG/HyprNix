local statusOk, drop = pcall(require, "dropbar")
if not statusOk then
	return
end

drop.setup({})
