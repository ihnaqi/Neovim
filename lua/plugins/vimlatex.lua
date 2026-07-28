return {
  "lervag/vimtex",
  lazy = false, -- DO NOT lazy load
  init = function()
    vim.g.vimtex_view_method = "zathura"
    -- vim.g.maplocalleader = ","  -- or whatever you prefer
  end,
}
