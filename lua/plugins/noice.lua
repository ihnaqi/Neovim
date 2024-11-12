return {
   "folke/noice.nvim",
   event = "VeryLazy",
   opts = { noremap = true, silent = true },
   dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
   },
   config = function()
      require("noice").setup({
         lsp = {
            override = {
               ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
               ["vim.lsp.util.stylize_markdown"] = true,
               ["vim.lsp.util.get_documentation"] = true,
            },
         },
      })

      require("notify").setup({
         background_colour = "#000000",
      })
   end,
}