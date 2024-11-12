require("config.lazy")

-- local signs = { Error = "", Warn = "", Info = "", Hint = "" }
local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }
for type, icon in pairs(signs) do
   local hl = "DiagnosticSign" .. type
   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.opt.laststatus = 3
