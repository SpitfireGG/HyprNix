local statusOK, hardtime = pcall(require, "hardtime")
if not statusOK then
	return
end

hardtime.setup()
