return {
   -- I need to configure nvim-dap for node applications, both borwser and server side
   "mfussenegget/nvim-dap",
   config = function()
      local dap = require("dap")
      -- Keymaps to control the debugger
      local set = vim.api.set
      set("n", "c", require("dap").continue, { noremap = true })
      set("n", "o", require("dap").step_over, { noremap = true })
      set("n", "i", require("dap").step_into, { noremap = true })
      set("n", "u", require("dap").step_out, { noremap = true })
      set("n", "<leader>b", require("dap").toggle_breakpoint, { noremap = true })
      set("n", "<leader>B", function()
         require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end)
   end,
}
