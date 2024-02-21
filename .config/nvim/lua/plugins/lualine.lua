return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            -- set an empty statusline till lualine loads
            vim.opt.statusline = ""
        else
            -- hide the statusline on the starter page
            vim.opt.laststatus = 0
        end
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
        return {
            options = {
                theme = "gruvbox",
                globalstatus = true,
                disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
            },
            extensions = { "lazy" }
        }
    end,
}
