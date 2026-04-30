local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


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
