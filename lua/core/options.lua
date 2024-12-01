vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=NONE]])
vim.cmd([[hi NvimTreeNormalNC guibg=NONE ctermbg=NONE]])

vim.opt.clipboard = "unnamedplus" -- turns clipboard sharing between os and vim on
vim.opt.linebreak = true -- turns line break on
vim.opt.mouse = "a"
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.softtabstop = 3
vim.opt.swapfile = false -- I don't need swap files, they alway haunt me
vim.opt.laststatus = 3

vim.opt.nu = true
vim.opt.rnu = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 3
vim.opt.tabstop = 3
vim.opt.cursorline = true
vim.opt.termguicolors = true

-- Disabling `-- INSERT --`
vim.opt.showmode = false

-- Disable line wrap by default
vim.opt.wrap = false

-- Disable highing of search
vim.opt.hlsearch = false

-- Disable Ctrl-v paste
vim.opt.paste = false

-- Make my cursor blinking, on insert mode it will be a line, on normal mode it will be a block and block on command and visual mode
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- Help me write configuration for better navigation using hjkl keys in wrapped mode
vim.cmd([[noremap j gj]])
vim.cmd([[noremap k gk]])
vim.cmd([[noremap $ g$]])
vim.cmd([[noremap ^ g^]])
vim.cmd([[noremap _ g_]])
