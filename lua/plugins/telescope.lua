return {
   "nvim-telescope/telescope.nvim",
   dependencies = {
      "nvim-lua/plenary.nvim",
   },
   config = function()
      require("telescope").setup({
         defaults = {
            -- I want the prompt_prefix to be a solid arrows head pointing towards the right
            prompt_prefix = "▶ ",
            sorting_strategy = "descending",
            layout_strategy = "horizontal",
            mappings = {
               i = {
                  ["<C-j>"] = function()
                     require("telescope.actions").move_selection_next()
                  end,
                  ["<C-k>"] = function()
                     require("telescope.actions").move_selection_previous()
                  end,
               },
            },
            file_ignore_patterns = {
               ".git/",
               "pack/",
               "dist/",
               "node_modules/",
               "test/",
               "*.d.ts",
               "*.js.map",
            },
         },
      })

      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
      vim.keymap.set("n", "<leader>fc", builtin.commands, {})
      vim.keymap.set("n", "<leader>fr", builtin.git_files, {})
   end,
}
