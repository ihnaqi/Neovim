return {
   cmd = { "texlab" },
   filetypes = { "tex", "plaintex", "bib" },
   root_markers = { ".latexmkrc", ".texlab-root", "texlabroot", ".git" },
   settings = {
      texlab = {
         build = {
            executable = "latexmk",
            args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
            onSave = true,
            forwardSearchAfter = true,
         },
         forwardSearch = {
            executable = "C:/tools/SumatraPDF/SumatraPDF.exe",
            args = { "-reuse-instance", "%p", "-forward-search", "%f", "%l" },
         },
         chktex = { onOpenAndSave = true },
         latexFormatter = "latexindent",
      },
   },
   single_file_support = true,
   log_level = vim.lsp.protocol.MessageType.Warning,
}
