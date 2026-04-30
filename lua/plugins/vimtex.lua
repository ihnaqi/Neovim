return {
    "lervag/vimtex",
    lazy = false,
    init = function()
        vim.g.vimtex_view_method = "general"
        vim.g.vimtex_view_general_viewer = "C:/tools/SumatraPDF/SumatraPDF.exe"
        vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_quickfix_mode = 0
        vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
    end,
}
