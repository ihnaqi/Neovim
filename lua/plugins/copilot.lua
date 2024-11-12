return {
   "github/copilot.vim",
   config = function()
      -- Lets create a global toggle function to toggle the state of copilot on and off
      --[[
      local state = vim.g.copilot_enabled or false
      local function toggle()
         state = not state
         vim.g.copilot_enabled = state
         if state then
            vim.api.nvim_command("Copilot_enable")
         else
            vim.api.nvim_command("Copilot_disable")
         end
      end

      -- Lets call the above funcion when ctrl + shit + o is pressed in insert mode
      --]]
   end,
}
