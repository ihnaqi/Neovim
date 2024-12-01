return {
   "nvim-treesitter/nvim-treesitter",
   build = ":TSUpdate",
   config = function()
      local opts = {
         ensure_install = {
            "rust",
            "ts_ls",
            "bash",
            "javascript",
            "java",
            "typescript",
            "lua",
            "json",
            "tsx",
            "css",
            "html",
            "dockerfile",
            "markdown",
            "markdown_inline",
            "gitignore",
            "yaml"
         },
         highligt = {
            enable = true
         },
         auto_install = true,
         indent =  { enable = true }
      }
      -- require("nvim-treesitter.install").prefer_git = false
    require("nvim-treesitter.install").compilers = { "zig" }
    require("nvim-treesitter.configs").setup(opts)
   end
}
