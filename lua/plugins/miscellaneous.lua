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
      "norcalli/nvim-colorizer.lua",
      config = function()
         require("colorizer").setup()
      end
   },
   {
      -- My Favorite Undo Tree
      "mbbill/undotree",
      keys = {
         { "<C-u>", vim.cmd.UndotreeToggle, desc = "Undotree: toggle panel" }
      },
      init = function()
         vim.opt.undodir = os.getenv("HOME") .. "/.unodidr"
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
   }
}
