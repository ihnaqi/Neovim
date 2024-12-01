return {
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
