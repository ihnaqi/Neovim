local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Loading Custom Keymaps and Options
require("core.keymaps")
require("core.options")

require("lazy").setup({
	{
		require("plugins.colorscheme"),
   require("plugins.telescope"),
   require("plugins.copilot"),
   require("plugins.lualine"),
   require("plugins.treesitter"),
   require("plugins.gitsigns"),
   require("plugins.nvimtree"),
   require("plugins.autopair"),
   require("plugins.indent-blankline"),
   require("plugins.noice"),
   require("plugins.undotree"),
   -- Need to add DAP for node, java, azure, typescrpit
   -- require("plugins.debug"),
   require("plugins.markdown"),
   require("plugins.harpoon"),
   require("plugins.lsp"),
      require("plugins.autocomplete"),
      require("plugins.autoformat")
	}
})


-- local signs = { Error = "", Warn = "", Info = "", Hint = "" }
local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }
for type, icon in pairs(signs) do
   local hl = "DiagnosticSign" .. type
   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.opt.laststatus = 3
