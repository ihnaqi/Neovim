return {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "biome", "biome-organize-imports" },
                javascriptreact = { "biome", "biome-organize-imports" },
                typescript = { "biome", "biome-organize-imports" },
                typescriptreact = { "biome", "biome-organize-imports" },
                rust = { "rustfmt" },
            },
            format_on_save = {
                timeout_ms = 2000,
                async = false,
                lsp_format = "never",
            },
        })
    end,
}
