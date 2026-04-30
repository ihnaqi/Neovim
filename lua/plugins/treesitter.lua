return {
   "nvim-treesitter/nvim-treesitter",
   build = ":TSUpdate",
   config = function()
      require("nvim-treesitter.install").compilers = { "zig" }

      require("nvim-treesitter.configs").setup({
         modules = {},
         sync_install = false,
         ensure_installed = {
            "lua",
            "javascript",
            "typescript",
            "tsx",
            "rust",
            "vim",
            "vimdoc",
         },
         highlight = {
            enable = true,
         },
         auto_install = true,
         ignore_install = { "latex" },
         indent = {
            enable = true,
         },
      })
   end,
}
