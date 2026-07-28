-- ~/.config/nvim/lua/plugins/treesitter.lua
--
-- nvim-treesitter rewritten for the new `main` branch.
-- The old `master` API -- require("nvim-treesitter.configs").setup{...} with
-- ensure_installed / highlight / indent / auto_install -- no longer exists.

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- master is frozen; main is the rewrite (and the new default branch)
  lazy = false,    -- the main branch does NOT support lazy-loading
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    -- Parsers to install up front (replaces `ensure_installed`).
    -- install() is async and is a no-op when a parser is already present.
    local ensure_installed = {
      "lua",
      "javascript",
      "typescript",
      "tsx",
      "rust",
      "vim",
      "vimdoc",
      "latex",
      "bibtex",
    }
    ts.install(ensure_installed)

    -- master's global switches (highlight / indent / auto_install) are gone.
    -- Features are now enabled per-buffer from a FileType autocommand.
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
      pattern = "*",
      callback = function(args)
        local buf = args.buf
        local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
        if not lang then
          return
        end
        -- Suppress "no parser" warnings for virtual/fake filetypes
        local skip = {
          snacks_layout_box = true,
          snacks_picker_input = true,
          snacks_picker_list = true,
          snacks_notif = true,
          noice = true
        }
        if skip[lang] or lang:match("^snacks_") then
          return -- ← add this block
        end


        -- Start highlighting. If the parser isn't installed yet, install it
        -- on the fly (this is the old `auto_install = true`), then start.
        -- pcall keeps things error-free for filetypes that have no parser.
        if not pcall(vim.treesitter.start, buf, lang) then
          local ok = pcall(function()
            ts.install({ lang }):wait(30000)
          end)
          if not ok or not pcall(vim.treesitter.start, buf, lang) then
            return
          end
        end

        -- Treesitter-based indentation (replaces `indent = { enable = true }`).
        -- Still experimental; comment this line out if any filetype misbehaves.
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
