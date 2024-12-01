return {
  "olimorris/onedarkpro.nvim",
  lazy = false,
  priority = 1000, -- Ensure it loads first
  config = function()
     require("onedarkpro").setup({
        theme = "onedark_dark",
        options = {
           transparency = true,
           cursorline = true,
           terminal_colors = true
        }
     })
     local bg_transparent = true
     local toggle_bg = function()
        bg_transparent = not bg_transparent
        vim.cmd("colorscheme onedark_dark")
     end
     vim.keymap.set("n", "<leader>bg", toggle_bg, { noremap = true, silent = true })
     vim.cmd("colorscheme onedark_dark")
  end
}
