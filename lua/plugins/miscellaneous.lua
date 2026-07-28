return {
   {
      -- Detects tab stop and shiftwidth automatically
      "tpope/vim-sleuth"
   },
   {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true,
      opts = {}
   },
   {
      "folke/todo-comments.nvim",
      event = "VimEnter",
      dependencies = {
         "nvim-lua/plenary.nvim"
      },
      opts = {
         signs = false
      }
   },
   {
      "catgoose/nvim-colorizer.lua",
      event = "BufReadPre",
      opts = {},
   },
   {
      -- My Favorite Undo Tree
      "mbbill/undotree",
      keys = {
         { "<C-u>", vim.cmd.UndotreeToggle, desc = "Undotree: toggle panel" }
      },
      init = function()
         -- expand("~") instead of $HOME: HOME is not set by cmd/PowerShell on
         -- Windows, which would make this concatenate a nil and error out.
         vim.opt.undodir = vim.fn.expand("~/.undodir")
         vim.opt.undofile = true
         vim.opt.undolevels = 10000
      end
   },
   {
      -- Noice for command line
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {},
      dependencies = {
         "MunifTanjim/nui.nvim"
      }
   },
   {
      "kylechui/nvim-surround",
      version = "^4.0.0",  -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
      -- config = function()
      --     require("nvim-surround").setup({
      --         -- Put your configuration here
      --     })
      -- end
   }
}
