return {
    {
        "tpope/vim-fugitive",
        event = "VimEnter",
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {
            -- signs = {
            --     add = { text = '+' },
            --     change = { text = '~' },
            --     delete = { text = '_' },
            --     topdelete = { text = '‾' },
            --     changedelete = { text = '~' },
            -- },
        },
    }
}
