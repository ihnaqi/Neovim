return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            -- Make diagnostic messages visible. Signs (E/W/H) and underline are
            -- on by default, but the message text is NOT rendered without this.
            vim.diagnostic.config({
                virtual_text = {
                    spacing = 4,
                    prefix = '●',
                    source = 'if_many',
                },
                underline = true,
                signs = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = 'rounded',
                    source = 'if_many',
                },
            })

            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } }
                    }
                }
            })
            -- vim.lsp.enable('lua_ls')

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('my.lsp', {}),
                callback = function(ev)
                    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
                    if not client then return end

                    -- Go to definition (Ctrl+click equivalent)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to Definition" })

                    -- Go to declaration
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to Declaration" })

                    -- Go to implementation
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
                        { buffer = ev.buf, desc = "Go to Implementation" })

                    -- Go to type definition
                    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition,
                        { buffer = ev.buf, desc = "Go to Type Definition" })

                    -- Show references
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = "Show References" })

                    -- Hover documentation (like hovering in VSCode)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover Docs" })

                    -- Rename symbol
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename Symbol" })

                    -- Code actions (like Ctrl+. in VSCode)
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code Action" })


                    -- if client:supports_method('textDocument/implementation') then
                    -- Create a keymap for vim.lsp.buf.implementation ...
                    -- end

                    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
                    --[[ if client:supports_method('textDocument/completion') then
                        -- Optional: trigger autocompletion on EVERY keypress. May be slow!
                        -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
                        -- client.server_capabilities.completionProvider.triggerCharacters = chars

                        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
                    end ]] --

                    -- Auto-format ("lint") on save.
                    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
                    if not client:supports_method('textDocument/willSaveWaitUntil')
                        and client:supports_method('textDocument/formatting') then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                            buffer = ev.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
                            end,
                        })
                    end
                end,
            })
        end,
    }
}
