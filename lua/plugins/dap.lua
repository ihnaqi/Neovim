return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text"
    },
    keys = {
      { "<F5>",       function() require("dap").continue() end,          desc = "Debug: Continue" },
      { "<F10>",      function() require("dap").step_over() end,         desc = "Debug: Step Over" },
      { "<F11>",      function() require("dap").step_into() end,         desc = "Debug: Step Into" },
      { "<F12>",      function() require("dap").step_out() end,          desc = "Debug: Step Out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function()
        require("dap").set_breakpoint(vim.fn.input("Condition: "))
      end, desc = "Conditional Breakpoint" },
      { "<leader>dl", function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log message: "))
      end, desc = "Log Point" },
      { "<leader>dr", function() require("dap").repl.open() end,         desc = "Open REPL" },
      { "<leader>dc", function() require("dap").run_to_cursor() end,     desc = "Run to Cursor" },
      { "<leader>dt", function() require("dap").terminate() end,         desc = "Terminate" },
      { "<leader>du", function() require("dapui").toggle() end,          desc = "Toggle DAP UI" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      ---------------------------------------------------------
      -- UI setup
      ---------------------------------------------------------
      dapui.setup()

      -- Setting up virtual text
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        commented = false,
        all_frames = false,
        highlight_changed_variables = true,
      })

      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- show variable value on hover during debug sessions
      dap.listeners.after.event_initialized["hover_setup"] = function()
        vim.keymap.set("n", "K", function()
          require("dap.ui.widgets").hover()
        end, { buffer = true, desc = "DAP Hover" })
      end

      -- restore K to default when session ends
      dap.listeners.before.event_terminated["hover_teardown"] = function()
        vim.keymap.del("n", "K", { buffer = true })
      end
      dap.listeners.before.event_exited["hover_teardown"] = function()
        pcall(vim.keymap.del, "n", "K", { buffer = true })
      end

      -- Have to optionally bind .vscode/launch.json ()
      -- @Deprecated
      --[[require("dap.ext.vscode").load_launchjs(nil, {
        ["pwa-node"] = { "javascript", "typescript" },
        ["codelldb"] = { "rust" },
        ["bun"] = { "typescript", "javascript" },
      })
      --]]

      -- nicer breakpoint signs
      vim.fn.sign_define("DapBreakpoint",          { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition",  { text = "◐", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapLogPoint",             { text = "◆", texthl = "DiagnosticInfo" })
      vim.fn.sign_define("DapStopped",              { text = "▶", texthl = "DiagnosticOk", linehl = "DapStoppedLine" })

      ---------------------------------------------------------
      -- Adapters
      -- Add new adapters here as simple entries
      ---------------------------------------------------------
      local adapters = {
        codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            command = "C:\\tools\\codelldb\\extension\\adapter\\codelldb.exe",
            args = { "--port", "${port}" },
          },
        },
        bun = {
        type = "executable",
        command = "bun",
        args = {
          vim.fn.expand("~/.local/share/bun-debug/dap-server.ts"),
          },
        },
        ["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              vim.fn.stdpath("data") .. "\\js-debug\\src\\dist\\src\\vsDebugServer.js",
              "${port}",
            },
          },
        },
      }

      for name, config in pairs(adapters) do
        dap.adapters[name] = config
      end

      ---------------------------------------------------------
      -- Helper utils
      ---------------------------------------------------------
      local utils = {
        -- prompt for a file path with a default directory
        pick_file = function(prompt, default_dir)
          return function()
            return vim.fn.input(prompt, default_dir, "file")
          end
        end,

        -- build cargo and return the binary path
        cargo_build = function()
          vim.fn.system("cargo build")
          if vim.v.shell_error ~= 0 then
            vim.notify("cargo build failed!", vim.log.levels.ERROR)
            return nil
          end
          -- try to parse binary name from Cargo.toml
          local cargo_path = vim.fn.getcwd() .. "\\Cargo.toml"
          if vim.fn.filereadable(cargo_path) == 1 then
            for line in io.lines(cargo_path) do
              local name = line:match('^name%s*=%s*"(.-)"')
              if name then
                return vim.fn.getcwd() .. "\\target\\debug\\" .. name .. ".exe"
              end
            end
          end
          return vim.fn.input("Binary: ", vim.fn.getcwd() .. "\\target\\debug\\", "file")
        end,
      }

      ---------------------------------------------------------
      -- Language configurations
      -- Each key maps a filetype to a list of debug configs.
      -- To add a new language, just add a new entry.
      ---------------------------------------------------------
      local language_configs = {
        rust = {
          {
            name = "Launch (cargo build)",
            type = "codelldb",
            request = "launch",
            program = utils.cargo_build,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
          },
          {
            name = "Attach to process",
            type = "codelldb",
            request = "attach",
            pid = require("dap.utils").pick_process,
          },
        },

        javascript = {},
        -- In your adapters table, remove the bun executable adapter and keep what you have.
        -- We'll use pwa-node for bun since it can connect to bun's inspector.
        -- In your language_configs table, update typescript:
        typescript = {
          {
            name = "Debug Bun (launch)",
            type = "pwa-node",
            request = "launch",
            runtimeExecutable = "bun",
            runtimeArgs = { "--inspect-brk", "run" },
            program = "${workspaceFolder}/src/index.ts",
            cwd = "${workspaceFolder}",
            attachSimplePort = 6499,
          },
          {
            name = "Debug Bun (attach)",
            type = "pwa-node",
            request = "attach",
            port = 6499,
            cwd = "${workspaceFolder}",
          },
          -- keep the existing node configs too
          {
            name = "Launch file (Node)",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            name = "Attach to process (Node)",
            type = "pwa-node",
            request = "attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }, -- filled below
      }

      -- typescript reuses the same configs as javascript
      language_configs.javascript = language_configs.typescript

      for lang, configs in pairs(language_configs) do
        dap.configurations[lang] = configs
      end
    end,
  },
}
