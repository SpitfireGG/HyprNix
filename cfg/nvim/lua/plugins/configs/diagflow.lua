local statOk, diagflow = pcall(require, "diagflow")
if not statOk then
    print("diagflow plugins misbehaves")
end

diagflow.setup({
    enable = true,
    max_width = 60,     -- The maximum width of the diagnostic messages
    max_height = 10,    -- the maximum height per diagnostics
    severity_colors = { -- The highlight groups to use for each diagnostic severity level
        error = "DiagnosticFloatingError",
        warning = "DiagnosticFloatingWarn",
        info = "DiagnosticFloatingInfo",
        hint = "DiagnosticFloatingHint",
    },
    format = function(diagnostic)
        return diagnostic.message
    end,
    gap_size = 1,
    scope = 'cursor', -- 'cursor', 'line' this changes the scope, so instead of showing errors under the cursor, it shows errors on the entire line.
    padding_top = 0,
    padding_right = 3,
    text_align = 'right',                                  -- 'left', 'right'
    placement = 'inline',                                  -- 'top', 'inline'
    inline_padding_left = 6,                               -- the padding left when the placement is inline
    update_event = { 'DiagnosticChanged', 'BufReadPost' }, -- the event that updates the diagnostics cache
    toggle_event = {},                                     -- if InsertEnter, can toggle the diagnostics on inserts
    show_sign = false,                                     -- set to true if you want to render the diagnostic sign before the diagnostic message
    render_event = { 'DiagnosticChanged', 'CursorMoved' }
})
