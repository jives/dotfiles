return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { 'BufReadPre', 'BufNewFile' },
        main = "ibl",
        opts = {
            indent = {
                char = "┊"
            },
            scope = { enabled = false },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
            }
        }
    },
    {
        "echasnovski/mini.indentscope",
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            symbol = "┊"
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    }
}
