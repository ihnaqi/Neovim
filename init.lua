-- local info = debug.getinfo(1, "S")
-- local script_path = info.source:sub(2)
-- print(script_path)
-- local dirname = script_path:match("(.*\\)")
-- print(dirname)
-- local filename = script_path:match("([^\\]+)$")
-- print(filename)

require("core.keymaps")
require("core.options")

-- Adding Lazy as package manager
require("config.lazy")
require("config.lsp")

-- Attaching Auto commands, LSP stuffs
require("core.autocmd")

-- vim.g.vimtex_compiler_latexmk_engines = {
--    _ = 'lualatex'
-- }
