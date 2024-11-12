return {
   "ThePrimeagen/harpoon",
   branch = "harpoon2",
   dependencies = {
      "nvim-lua/plenary.nvim",
   },
   config = function()
      local harpoon = require("harpoon").setup()

      harpoon.setup()

      local set = vim.keymap.set
      set("n", "<leader>a", function() harpoon:list():add() end)
      set("n", "<leader>ls", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      set("n", "<C-h>", function() harpoon:list():select(1) end)
      set("n", "<C-t>", function() harpoon:list():select(2) end)
      set("n", "<C-n>", function() harpoon:list():select(3) end)
      set("n", "<C-s>", function() harpoon:list():select(4) end)

      -- Toggle between previsous and next files
      set("n", "<C-S-P>", function() harpoon:list():prev() end)
      set("n", "<C-S-N>", function() harpoon:list():next() end)
   end,
}
