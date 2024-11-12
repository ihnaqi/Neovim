---
-- LSP setup
---
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
   -- see :help lsp-zero-keybindings
   -- to learn the available actions
   lsp_zero.default_keymaps({ buffer = bufnr })
   lsp_zero.buffer_autoformat()
end)

--- if you want to know more about lsp-zero and mason.nvim
--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
   handlers = {
      function(server_name)
         require('lspconfig')[server_name].setup({})
      end,
      lua_ls = function()
         -- (Optional) configure lua language server
         local lua_opts = lsp_zero.nvim_lua_ls()
         require('lspconfig').lua_ls.setup(lua_opts)
      end,
   }
})

---
-- Autocompletion config
---
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
   mapping = cmp.mapping.preset.insert({
      -- `Enter` key to confirm completion
      ['<CR>'] = cmp.mapping.confirm({ select = false }),

      -- Ctrl+Space to trigger completion menu
      ['<C-Space>'] = cmp.mapping.complete(),

      -- Navigate between snippet placeholder
      ['<C-f>'] = cmp_action.luasnip_jump_forward(),
      ['<C-b>'] = cmp_action.luasnip_jump_backward(),

      -- Navigate between completion items
      ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

      -- Ctrl + x to abort the completion
      ['<C-x>'] = cmp.mapping.abort(),

      -- Scroll up and down in the completion documentation
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
   }),
   snippet = {
      expand = function(args)
         require('luasnip').lsp_expand(args.body)
      end,
   },
})


-- format on save shoud run only once, before the language servers are active.
lsp_zero.format_on_save({
   format_opts = {
      async = false,
      timeout_ms = 10000,
   },
   servers = {
      ['ts_ls'] = { 'javascript', 'typescript' },
      ['rust_analyzer'] = { 'rust' },
      ['clangd'] = { 'c', 'cpp' },
      ['jsonls'] = { 'json' },
      ['sumneko_lua'] = { 'lua' },
      ['html'] = { 'html' },
      ['cssls'] = { 'css' },
      ['yamlls'] = { 'yaml' },
      ['bashls'] = { 'sh' },
      ['vimls'] = { 'vim' },
      ['java_language_server'] = { 'java' },
      ['efm'] = { 'lua', 'javascript', 'typescript', 'css', 'html', 'json', 'yaml', 'markdown', 'vim' },
   }
})

vim.api.nvim_create_autocmd('LspAttach', {
   desc = 'LSP Actions',
   callback = function(event)
      local opts = { buffer = event.buf }

      vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      vim.keymap.set('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      vim.keymap.set('n', 'gA', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      vim.keymap.set('n', 'gF', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
      vim.keymap.set('n', 'gff', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)

      vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
      vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
      vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

      local sign = {
         Error = '',
         Warn = '',
         Info = '',
         Hint = '',
      }

      vim.diagnostic.config({
         signs = sign,
         virtual_text = {
            spacing = 3,
            prefix = '',
         },
         update_in_insert = false,
         underline = true,
         severity_sort = true,
      })
   end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').ts_ls.setup({})
require('lspconfig').rust_analyzer.setup({})
