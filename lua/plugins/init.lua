return {
   {
      "LazyVim/LazyVim",
   },
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
   -- Neogit
   {
      "TimUntersberger/neogit",
      dependencies = "nvim-lua/plenary.nvim",
      opts = {
         integrations = {
            diffview = true,
         },
      },
   },

   -- Diff view for git
   {
      "sindrets/diffview.nvim",
      dependencies = "nvim-lua/plenary.nvim",
   },
}
