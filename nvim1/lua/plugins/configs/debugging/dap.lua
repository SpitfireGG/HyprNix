local stateOK, dap = pcall(require("dap"))
if not stateOK then
    print("debugger is not installed and may crash keep on")
end
