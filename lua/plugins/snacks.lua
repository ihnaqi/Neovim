return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        picker = {
            enabled = true,
            sources = {
                explorer = {
                    hidden = false,
                    ignored = false,
                    layout = {
                        preset = "sidebar",
                        -- `false` is handled by snacks (picker/config/init.lua), but its
                        -- annotation only declares `"main"` -- silence the false positive.
                        ---@diagnostic disable-next-line: assign-type-mismatch
                        preview = false,
                        layout = {
                            position = "left",
                            width = 35,
                            box = "vertical",
                            { win = "input", height = 1,     border = "bottom" },
                            { win = "list",  border = "none" },
                        },
                    },
                    win = {
                        list = {
                            keys = {
                                ["H"] = "toggle_hidden",
                                ["I"] = "toggle_ignored",
                            },
                        },
                    },
                },
                files = {
                    hidden = true,
                    exclude = { "node_modules", ".git", "dist", ".astro", "public" }
                },
                grep = {
                    hidden = true,
                    exclude = { "node_modules", ".git", "dist", "public", ".astro" },
                }
            },
            layouts = {
                custom = {
                    reverse = true,
                    layout = {
                        box = "vertical",
                        width = 0.8,
                        height = 0.8,
                        border = "rounded",
                        title = "{title} {live} {flags}",
                        title_pos = "center",
                        {
                            box = "horizontal",
                            { win = "list",    width = 0.4,    border = "none" },
                            { win = "preview", border = "left" },
                        },
                        { win = "input", height = 1, border = "top" },
                    },
                },
            },
            layout = {
                preset = "custom",
            },
        },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = {
            enabled = true,
            animate = {
                duration = { step = 15, total = 150 },
                easing = "outQuad", -- "linear" or "outCubic" are also valid options
            },
        },
        animate_repeat = {
            delay = 80,
            duration = {
                step = 5,
                total = 50
            },
            easing = "linear"
        },
        -- statuscolumn = { enabled = true },
        words = { enabled = true },
    },
    keys = {
        -- Pickers
        { "<leader>ff", function() Snacks.picker.files() end,                                  desc = "Find Files" },
        { "<leader>fh", function() Snacks.picker.files({ hidden = true, ignored = true }) end, desc = "Find Hidden/Dot Files" },
        { "<leader>fg", function() Snacks.picker.grep() end,                                   desc = "Grep Workspace" },
        { "<leader>fb", function() Snacks.picker.buffers() end,                                desc = "Find Buffers" },
        { "<leader>sk", function() Snacks.picker.keymaps() end,                                desc = "Search Keymaps" },
        { "<leader>mk", function() Snacks.picker.marks() end,                                  desc = "Search Marks" },
        { "<leader>nh", function() Snacks.picker.notifications() end,                          desc = "Notification History" },

        -- Explorer
        { "<leader>ee", function() Snacks.picker.explorer() end,                               desc = "File Explorer" },

        -- Zen
        { "<leader>z",  function() Snacks.zen() end,                                           desc = "Toggle Zen Mode" },
        { "<leader>Z",  function() Snacks.zen.zoom() end,                                      desc = "Zen Zoom" },
    },
}
