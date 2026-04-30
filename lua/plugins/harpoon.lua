return {
   "ThePrimeagen/harpoon",
   branch = "harpoon2",
   dependencies = {
      "nvim-lua/plenary.nvim"
   },
   config = function()
      local harpoon = require("harpoon")
      harpoon.setup()
      local set = vim.keymap.set

      -- Setting default keymaps
      set("n", "<leader>a", function() harpoon:list():add() end)
      set("n", "<leader>ls", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      set("n", "<C-t>", function() harpoon:list():select(1) end)
      set("n", "<C-y>", function() harpoon:list():select(2) end)
      set("n", "<C-n>", function() harpoon:list():select(3) end)
      set("n", "<C-s>", function() harpoon:list():select(4) end)

      -- Toogle between previous and next buffers
      set("n", "<leader>pr", function() harpoon:list():prev() end)
      set("n", "<leader>nt", function() harpoon:list():next() end)
   end
}
