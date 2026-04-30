-- rust_analyzer.lua
return {
   cmd = { "rust-analyzer" },
   filetypes = { "rust" },
   root_markers = { "Cargo.toml", "rust-project.json", ".git" },
   settings = {
      ["rust-analyzer"] = {
         cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
         },
         checkOnSave = {
            command = "clippy", -- or "check"
            allFeatures = true,
            enable = true
         },
         procMacro = {
            enable = true,
         },
         diagnostics = {
            enable = true,
            experimental = {
               enable = true,
            },
         },
         imports = {
            granularity = "module",
            prefix = "crate",
         },
         inlayHints = {
            bindingModeHints = { enable = true },
            chainingHints = { enable = true },
            closingBraceHints = { enable = true },
            closureReturnTypeHints = { enable = "with_block" },
            lifetimeElisionHints = { enable = "always" },
            parameterHints = { enable = true },
            reborrowHints = { enable = "always" },
            typeHints = { enable = true },
         },
         lens = {
            enable = true,
            references = true,
            methodReferences = true,
         },
         hover = {
            actions = {
               enable = true,
               references = true,
               implementations = true,
            },
         },
         rustfmt = {
            extraArgs = { "--edition", "2021" },
         },
      },
   },
   single_file_support = true,
   log_level = vim.lsp.protocol.MessageType.Warning,
}
