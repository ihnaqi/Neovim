return {
   "nvim-treesitter/nvim-treesitter",
   build = ":TSUpdate",
   opts = {
      ensure_installed = {
         "bash",
         "css",
         "html",
         "java",
         "javascript",
         "json",
         "lua",
         "markdown",
         "rust",
         "typescript",
      },
      highlight = {
         enable = true,
      },

      incremental_selection = {
         enable = true,
         keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
         },
      },
      indent = {
         enable = true,
      },
   },
   config = function(_, opts)
      require "nvim-treesitter.install".prefer_git = false
      require "nvim-treesitter.install".compilers = { "zig" }
      require("nvim-treesitter.configs").setup(opts)
   end,
}
