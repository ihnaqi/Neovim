local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
   })
end

vim.opt.rtp:prepend(lazypath)

-- Load custom configurations
require("config.options")
require("config.keymaps")

-- Load Lazy Plugins
require("lazy").setup({
   { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
   { 'williamboman/mason.nvim' },
   { 'williamboman/mason-lspconfig.nvim' },
   { 'neovim/nvim-lspconfig' },
   { 'hrsh7th/cmp-nvim-lsp' },
   { 'hrsh7th/nvim-cmp' },
   { 'L3MON4D3/LuaSnip' },
   { require "plugins" },
})

require("config.lsp")
