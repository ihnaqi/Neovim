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
                    layout = {
                        preset = "sidebar",
                        preview = false,
                        layout = {
                            position = "left",
                            width = 35,
                            box = "vertical",
                            { win = "input", height = 1, border = "bottom" },
                            { win = "list", border = "none" },
                        },
                    },
                },
                files = {
                    hidden = true,
                    -- exclude = { "node_modules", ".git" }
                    args = { "--glob", "!node_modules", "--glob", "!.git" },
                },
                grep = {
                    hidden = true,
                    exclude = { "node_modules", ".git" },
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
                            { win = "list", width = 0.4, border = "none" },
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
        -- scroll = { enabled = true },
        scroll = {
            enabled = true,
            animate = {
                duration = { step = 15, total = 250 },
                easing = "linear",
            },
        },
        statuscolumn = { enabled = true },
        words = { enabled = true },
    },
    keys = {
        -- Pickers
        { "<leader>ff", function() Snacks.picker.files() end,         desc = "Find Files" },
        { "<leader>fg", function() Snacks.picker.grep() end,          desc = "Grep Workspace" },
        { "<leader>fb", function() Snacks.picker.buffers() end,       desc = "Find Buffers" },
        { "<leader>sk", function() Snacks.picker.keymaps() end,       desc = "Search Keymaps" },
        { "<leader>mk", function() Snacks.picker.marks() end,         desc = "Search Marks" },
        { "<leader>nh", function() Snacks.picker.notifications() end, desc = "Notification History" },

        -- Explorer
        { "<leader>ee", function() Snacks.picker.explorer() end,      desc = "File Explorer" },

        -- Zen
        { "<leader>z",  function() Snacks.zen() end,                  desc = "Toggle Zen Mode" },
        { "<leader>Z",  function() Snacks.zen.zoom() end,             desc = "Zen Zoom" },
    },
}
