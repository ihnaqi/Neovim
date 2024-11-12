return {
   'mbbill/undotree',
   cmd = 'UndotreeToggle',
   config = function()
      -- Let's setup undotree so that it will get loaded
      -- only when we actually need it.
      vim.api.nvim_set_keymap('n', '<C-u>', ':UndotreeToggle<CR>', { noremap = true, silent = true })
   end
}
