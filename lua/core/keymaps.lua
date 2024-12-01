-- Custom key mappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Map <Space> as leaer key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Getting out of insert mode
map("i", "hhg", "<ESC>", opts)
map("n", "<leader>pe", ":Explore<CR>", opts)
-- On Alt + z, toggle line wrap
map("n", "<A-z>", ":set wrap!<CR>:set lbr<CR>", opts)
map("i", "<A-z>", ":set wrap!<CR>:set lbr<CR>", opts)

-- Move a line up and down using Alt + j and Alt + k
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)

-- Disable arrow keys in insert mode
map("i", "<Up>", "<Nop>", opts)
map("i", "<Down>", "<Nop>", opts)
map("i", "<Left>", "<Nop>", opts)
map("i", "<Right>", "<Nop>", opts)

-- Disable arrow keys in normal mode
map("n", "<Up>", "<Nop>", opts)
map("n", "<Down>", "<Nop>", opts)
map("n", "<Left>", "<Nop>", opts)
map("n", "<Right>", "<Nop>", opts)

-- Disbale arrow keys in visual mode
map("v", "<Up>", "<Nop>", opts)
map("v", "<Down>", "<Nop>", opts)
map("v", "<Left>", "<Nop>", opts)
map("v", "<Right>", "<Nop>", opts)

-- Move between windows, by using Ctrl + Shift + h/j/k/l
map("n", "<C-S-h>", "<C-w>h", opts)
map("n", "<C-S-j>", "<C-w>j", opts)
map("n", "<C-S-k>", "<C-w>k", opts)
map("n", "<C-S-l>", "<C-w>l", opts)

-- Resize windows using <leader> + Shift + h/j/k/l
map("n", "<leader><S-h>", ":vertical resize -2<CR>", opts)
map("n", "<leader><S-j>", ":resize +2<CR>", opts)
map("n", "<leader><S-k>", ":resize -2<CR>", opts)
map("n", "<leader><S-l>", ":vertical resize +2<CR>", opts)

-- Toggle nvim-tree on <leader>ee
map("n", "<leader>ee", ":NvimTreeToggle<CR>", opts)

-- In normal mode enter visual-block mode with ctrl + v, right now when I press ctrl + v, it pastes the content of the clipboard
map("n", "<C-v>", "<Nop>", opts)
map("n", "<C-v>", "<C-q>", opts)

-- Remove word before the cursor when ctrl + baskcpace key is presssed and remove word after the cursor when ctrl + del is pressed
map("i", "<C-BS>", "<C-w>", opts)
map("i", "<C-del>", "<C-o>dw", opts)

-- Fold in <leader>fd and unfold in <leader>uf when in normal mode
map("n", "<leader>fd", "zf%", opts)
map("n", "<leader>ud", "zo", opts)

-- Enable and Disable Copilot
map("n", "<leader>ce", ":Copilot enable<CR>", opts)
map("n", "<leader>cd", ":Copilot disable<CR>", opts)
