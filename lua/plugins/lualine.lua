return {
   'nvim-lualine/lualine.nvim',
   dependencies = {
      'nvim-tree/nvim-web-devicons'
   },
   config = function()
      require('lualine').setup {
         options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '' }, -- Removing right separator for clean look
            section_separators = { left = '', right = '' },
            disabled_filetypes = { statusline = {}, winbar = {} },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = true,
            refresh = { statusline = 1000, tabline = 1000, winbar = 1000 }
         },
         sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = {
               function()
                  local mode = vim.fn.mode()
                  local mode_color = {
                     n = '#4f42b5',
                     i = '#55883b',
                     v = '#9a6735',
                     [''] = '#9a6735',
                     V = '#9a6735',
                     c = '#bd724d',
                     no = 'cyan',
                     s = 'cyan',
                     S = 'cyan',
                     [''] = 'cyan',
                     ic = 'yellow',
                     R = 'violet',
                     Rv = 'violet',
                     cv = '#9a6735',
                     ce = '#9a6735',
                     r = 'cyan',
                     rm = 'cyan',
                     ['r?'] = 'cyan',
                     ['!'] = 'red',
                     t = 'red',
                  }
                  -- Set the background color of the filename and ensure the separator blends with lualine_x
                  vim.api.nvim_command('hi! LualineFilename guibg=' .. mode_color[mode])
                  vim.api.nvim_command('hi! LualineSeparator guibg=' .. '#282c34' .. ' guifg=' .. mode_color[mode]) -- Set guibg to match lualine_x background

                  return "%#LualineFilename#" .. vim.fn.expand('%:t') .. ' ' .. "%#LualineSeparator#"
               end
            },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = {
               function()
                  return vim.fn.line('.') .. ':' .. vim.fn.col('.')
               end,
               'progress'
            },
            lualine_z = {
               function()
                  local date = os.date('*t')
                  local months = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" }
                  return '📅 ' ..
                      months[date.month] .. ',' .. date.day .. ' ' .. '🕒' .. ' ' .. vim.fn.strftime('%H:%M:%S')
               end
            }
         },
         inactive_sections = { lualine_a = {} },
         winbar = {},
         inactive_winbar = {},
         extensions = {}
      }
   end
}
