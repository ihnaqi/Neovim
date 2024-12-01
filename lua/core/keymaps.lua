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


-- Removing characters witout saving them or register
map("n", "x", '"_x', opts)

-- Vertical scroll and center
map("n", "<C-d", "<C-d>zz", opts)
map("n", "<C-u", "<C-u>zz", opts)

-- Find and center
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Navigating between splits
map("n", "<C-h>", ":wincmd h<CR>", opts)
map("n", "<C-j>", ":wincmd j<CR>", opts)
map("n", "<C-k>", ":wincmd k<CR>", opts)
map("n", "<C-l>", ":wincmd l<CR>", opts)

-- Centering the editor
map("n", "<leader>cc", "Gzz", opts)

-- Toogle line wrapping
map("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode (After indentation stay in visual mode don't need to come back to normal mode)
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Don't need the over written block, I over wrote it because I don't need it, so no need to keep it in my register
map("n", "p", '"_dP', opts)

-- Setting up diagnostic keys
-- map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
-- map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
-- map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
-- map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })

-- Resize splits using arrow keys
map("n", "<Up>", ":resize -2<CR>", opts)
map("n", "<Left>", ":vertical resize -2<CR>", opts)
map("n", "<Down>", ":reaize +2<CR>", opts)
map("n", "<Right>", ":vertical resize +2<CR>", opts)


