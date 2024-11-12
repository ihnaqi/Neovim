return {
   "wallpants/github-preview.nvim",
   cmd = { "GithubPreviewToggle" },
   keys = { "<leader>mpt" },
   opts = {
      -- config goes here
   },
   config = function(_, opts)
      local gpreview = require("github-preview")
      gpreview.setup({ opts })

      local fns = gpreview.fns
      -- Toggle the preview using Ctrl+Shift+P
      vim.keymap.set("n", "<leader>mpt", fns.toggle)
      vim.keymap.set("n", "<leader>mps", fns.single_file_toggle)
      vim.keymap.set("n", "<leader>mpd", fns.details_tags_toggle)

      -- Open the preview in insert mode using Ctrl+Shift+P
      -- vim.keymap.set("i", "<C-S-P>", fns.toggle)
   end,
}
