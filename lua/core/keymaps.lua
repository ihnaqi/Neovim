local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


vim.cmd("colorscheme habamax")

map("i", "hhg", "<Esc>", opts)
map("i", "<C-g>", "<Esc>", opts)
map("n", "<leader>pe", ":Explore<CR>", opts)

map("n", "<leader>fd", "zf%", opts)
map("n", "<leader>ud", "zo", opts)


map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

map("n", "<C-h>", ":wincmd h<CR>", opts)
map("n", "<C-j>", ":wincmd j<CR>", opts)
map("n", "<C-k>", ":wincmd k<CR>", opts)
map("n", "<C-l>", ":wincmd l<CR>", opts)

map("n", "<leader>lw", ":set wrap!<CR>", opts)

-- Stay in indent mode (After indentation stay in visual mode don't need to come back to normal mode)
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Brings things to the center (Cursor center)
map("n", "<leader>cc", "zz", opts)

-- Show diagnostic (error/warning) message under cursor in a floating window
vim.keymap.set("n", "<leader>vw", function()
   vim.diagnostic.open_float(nil, { scope = "line", focusable = false, border = "rounded" })
end, { desc = "View diagnostic in float" })

vim.api.nvim_create_autocmd("TermOpen", {
   group = vim.api.nvim_create_augroup("open-terminal", { clear = true }),
   callback = function()
      vim.opt.number = false
      vim.opt.relativenumber = false
   end
})

vim.keymap.set("n", "<leader>st", function()
   vim.cmd.vnew()
   vim.cmd.term()
   vim.cmd.wincmd("J")
   vim.api.nvim_win_set_height(0, 6)
end)

vim.api.nvim_create_autocmd("FileType", {
   pattern = "tex",
   callback = function()
      vim.keymap.set("n", "<leader>cmp", "<cmd>VimtexCompile<CR>", { buffer = true, desc = "Vimtex: Compile" })
      vim.keymap.set("n", "<leader>cn", "<cmd>VimtexClean<CR>", { buffer = true, desc = "Vimtex: Clean" })
   end
})
