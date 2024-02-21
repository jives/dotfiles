return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
        local dashboard = require("alpha.themes.dashboard")

        -- vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = blue })
        -- vim.api.nvim_set_hl(0, "NeovimDashboardLogo2", { fg = green, bg = blue })
        -- vim.api.nvim_set_hl(0, "NeovimDashboardLogo3", { fg = green })

        -- dashboard.section.header.val = {
        --     [[     █  █     ]],
        --     [[     ██ ██     ]],
        --     [[     █████     ]],
        --     [[     ██ ███     ]],
        --     [[     █  █     ]],
        --     [[]],
        --     [[N  E  O  V  I  M]],
        -- }

        -- dashboard.section.header.opts.hl = {
        --     { { "NeovimDashboardLogo1", 6, 8 },  { "NeovimDashboardLogo3", 9, 22 } },
        --     { { "NeovimDashboardLogo1", 6, 8 },  { "NeovimDashboardLogo2", 9, 11 }, { "NeovimDashboardLogo3", 12, 24 } },
        --     { { "NeovimDashboardLogo1", 6, 11 }, { "NeovimDashboardLogo3", 12, 26 } },
        --     { { "NeovimDashboardLogo1", 6, 11 }, { "NeovimDashboardLogo3", 12, 24 } },
        --     { { "NeovimDashboardLogo1", 6, 11 }, { "NeovimDashboardLogo3", 12, 22 } },
        -- }

        dashboard.section.buttons.val = {
            dashboard.button("f", " " .. " Find file",       "<cmd> Telescope find_files <cr>"),
            dashboard.button("n", " " .. " New file",        "<cmd> ene <BAR> startinsert <cr>"),
            dashboard.button("r", " " .. " Recent files",    "<cmd> Telescope oldfiles <cr>"),
            dashboard.button("g", " " .. " Find text",       "<cmd> Telescope live_grep <cr>"),
            dashboard.button("c", " " .. " Config",          "<cmd> lua require('lazyvim.util').telescope.config_files()() <cr>"),
            dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
            dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <cr>"),
            dashboard.button("q", " " .. " Quit",            "<cmd> qa <cr>"),
        }
        return dashboard
    end,
    config = function(_, dashboard)
        require("alpha").setup(dashboard.opts)

        vim.api.nvim_create_autocmd("User", {
            once = true,
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = "⚡ Neovim loaded "
                .. stats.loaded
                .. "/"
                .. stats.count
                .. " plugins in "
                .. ms
                .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}
