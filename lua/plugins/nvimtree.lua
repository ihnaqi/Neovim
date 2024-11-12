return {
   'nvim-tree/nvim-tree.lua',
   dependencies = {
      'nvim-tree/nvim-web-devicons',
   },
   config = function()
      local nvim_tree = require('nvim-tree')
      nvim_tree.setup()
      nvim_tree.setup({
         disable_netrw = true,
         hijack_netrw = true,
         open_on_tab = false,
         hijack_cursor = false,
         update_cwd = false,
         diagnostics = {
            enable = true,
            icons = {
               hint = "",
               info = "",
               warning = "",
               error = "",
            },
         },
         update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {
               'node_modules',
               '.git/'
            },
         },
         system_open = {
            cmd = nil,
            args = {},
         },
         view = {
            width = 30,
            side = 'right',
         },
         filters = {
            dotfiles = false,
         },
         renderer = {
            highlight_opened_files = "icon",
            root_folder_modifier = ":t",
            icons = {
               -- default = '',
               -- symlink = '',
               -- git = {
               -- unstaged = "✗",
               -- unstaged = '',
               -- staged = "✓",
               -- unmerged = "",
               -- renamed = "➜",
               -- untracked = "★",
               -- deleted = "",
               -- ignored = "◌",
               -- },
               -- folder = {
               --    default = "",
               --    open = "",
               --    symlink = "",
               -- },
            },
         }
      })
      vim.cmd [[
         hi NvimTreeNormal guibg=NONE ctermbg=NONE
      ]]
   end,
}
