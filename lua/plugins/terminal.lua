local M = {}

local state = {
    win = nil,
    buf = nil
}

-- Compute a centered floating-window config sized relative to the editor.
local function get_win_config()
    -- Calculate the central width and height
    local width = math.floor(vim.o.columns * 0.5)
    local height = math.floor(vim.o.lines * 0.5)

    -- Starting position to center the window
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    return {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
        title = "  Terminal ",
        title_pos = "center"
    }
end

-- State the buffer and window tracking state globally within the module
function M.toggle_terminal()
    -- Close / Hide open window
    if state.win and vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_close(state.win, true)
        state.win = nil
        return
    end

    -- Options for the floating window
    local win_options = get_win_config()

    -- Reuse existing terminal buffer if valid
    if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
        state.buf = vim.api.nvim_create_buf(false, true)
    end

    -- Open the floating window with the tracked buffer
    state.win = vim.api.nvim_open_win(state.buf, true, win_options)

    -- If buffer is new, spawn the terminal instance INTO state.buf
    if vim.bo[state.buf].buftype ~= "terminal" then
        vim.fn.jobstart(vim.o.shell, { term = true })
    end

    -- Automatically enter Insert (Terminal) made upon instance inside it
    vim.cmd("startinsert")
end

-- Cereating user command
vim.api.nvim_create_user_command("ToggleTerminal", M.toggle_terminal, {})

-- Re-center and re-scale the float when the Neovim UI is resized.
-- (Mouse move/resize works natively via the bordered float + `mouse = "a"`.)
vim.api.nvim_create_autocmd("VimResized", {
    group = vim.api.nvim_create_augroup("FloatingTerminalResize", { clear = true }),
    callback = function()
        if state.win and vim.api.nvim_win_is_valid(state.win) then
            vim.api.nvim_win_set_config(state.win, get_win_config())
        end
    end,
})

-- Keymaps to invoke and close the terminal
vim.keymap.set("n", "<leader>tt", M.toggle_terminal, { desc = "Toggle Floating Terminal" })
-- From inside the terminal, leave terminal-mode first, then toggle
vim.keymap.set("t", "<leader>tt", function()
    vim.cmd("stopinsert")
    M.toggle_terminal()
end, { desc = "Toggle Floating Terminal" })

-- This file is config (not a plugin), but lives under lua/plugins/ where
-- lazy.nvim imports it. Return an empty spec so lazy doesn't treat the
-- module table as a malformed plugin definition.
return {}
