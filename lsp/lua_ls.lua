return {
   cmd = {
      "lua-language-server"
   },
   filetypes = {
      "lua"
   },
   root_makers = {
      ".git", ".luacheckrc", ".luarc.json", ".stylua.toml", "selene.toml", "selene.yml", "stylua.toml"
   },
   settings = {
      Lua = {
         runtime = { version = "LuaJIT" },
         diagnostics = {
            globals = { "vim" }
         },
         workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false
         },
         telemetry = { enable = false }
      }
   },
   single_file_support = true,
   log_level = vim.lsp.protocol.MessageType.Warning
}
