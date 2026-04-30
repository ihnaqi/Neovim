-- ============================================================
-- Highlight on yank
-- ============================================================
vim.api.nvim_create_autocmd('TextYankPost', {
   desc     = 'Highlight when yanking text',
   group    = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
   callback = function()
      vim.highlight.on_yank()
   end,
})

-- ============================================================
-- LSP
-- ============================================================
local lsp_detach_group = vim.api.nvim_create_augroup('lsp-detach', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
   group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
   callback = function(event)
      local buf    = event.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if not client then return end

      -- --------------------------------------------------------
      -- Keymaps
      -- --------------------------------------------------------
      local map = function(keys, func, desc)
         vim.keymap.set('n', keys, func, { buffer = buf, desc = 'LSP: ' .. desc })
      end

      map('gl', vim.diagnostic.open_float, 'Open Diagnostic Float')
      map('K', vim.lsp.buf.hover, 'Hover Documentation')
      map('gs', vim.lsp.buf.signature_help, 'Signature Help')
      map('gD', vim.lsp.buf.declaration, 'Go to Declaration')
      map('gd', vim.lsp.buf.definition, 'Go to Definition')
      map('gi', vim.lsp.buf.implementation, 'Go to Implementation')
      map('<leader>gd', vim.lsp.buf.type_definition, 'Go to Type Definition')
      map('<leader>ref', vim.lsp.buf.references, 'Go to References')
      map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
      map('<leader>rn', vim.lsp.buf.rename, 'Rename All References')
      map('<leader>ft', function()
         -- vim.lsp.buf.format({ async = true })
         vim.lsp.buf.format({
            async = true,
            filter = function(client)
               return client.name == 'biome'
            end,
         })
      end, 'Format Buffer')
      map('<leader>v', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', 'Go to Definition in Vertical Split')

      -- --------------------------------------------------------
      -- ts_ls: disable formatting (use prettier or conform.nvim)
      -- --------------------------------------------------------
      if client.name == 'ts_ls' then
         client.server_capabilities.documentFormattingProvider      = false
         client.server_capabilities.documentRangeFormattingProvider = false
      end

      -- --------------------------------------------------------
      -- Inlay hints (rust-analyzer sends these per rust_analyzer.lua settings)
      -- --------------------------------------------------------
      if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
         vim.lsp.inlay_hint.enable(true, { bufnr = buf })
         map('<leader>ih', function()
            vim.lsp.inlay_hint.enable(
               not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }),
               { bufnr = buf }
            )
         end, 'Toggle Inlay Hints')
      end

      -- --------------------------------------------------------
      -- Code lens (rust-analyzer: run/debug/reference counts above fns)
      -- --------------------------------------------------------
      if client.supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
         vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'BufWritePost' }, {
            buffer   = buf,
            callback = function() vim.lsp.codelens.refresh() end,
         })
         vim.lsp.codelens.refresh()
         map('<leader>cl', vim.lsp.codelens.run, 'Run CodeLens')
      end

      -- --------------------------------------------------------
      -- Document highlight (highlight other uses of symbol under cursor)
      -- --------------------------------------------------------
      if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
         local highlight_group = vim.api.nvim_create_augroup('lsp-highlight-' .. buf, { clear = false })

         vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer   = buf,
            group    = highlight_group,
            callback = vim.lsp.buf.document_highlight,
         })
         vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer   = buf,
            group    = highlight_group,
            callback = vim.lsp.buf.clear_references,
         })

         vim.api.nvim_create_autocmd('LspDetach', {
            group    = lsp_detach_group,
            buffer   = buf,
            once     = true,
            callback = function()
               vim.lsp.buf.clear_references()
               vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = buf })
            end,
         })
      end
   end,
})

-- ============================================================
-- LSP restart command
-- ============================================================
vim.api.nvim_create_user_command('LspRestart', function()
   for _, c in ipairs(vim.lsp.get_clients()) do
      c.stop(true)
   end
   vim.defer_fn(function()
      vim.cmd('edit')
   end, 100)
end, { desc = 'Restart all LSP clients' })
