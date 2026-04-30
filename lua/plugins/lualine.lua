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
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
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
               {
                  function()
                     local filepath = vim.fn.expand('%:p')
                     if filepath == '' then return '[No Name]' end

                     local folder = vim.fn.expand('%:p:h:t') -- parent folder name
                     local filename = vim.fn.expand('%:t')   -- filename only
                     local modified = vim.bo.modified and ' ●' or ''

                     return folder .. '/' .. filename .. modified
                  end,
                  icon = '',
               }
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
                      months[date.month] .. ',' .. date.day .. ' ' .. '🕒' .. ' ' .. vim.fn.strftime('%H:%M')
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
