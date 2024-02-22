return {
    {
        "folke/neodev.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = true
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            --vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        build = function()
            pcall(vim.cmd, "MasonUpdate")
        end,
        config = true
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "L3MON4D3/LuaSnip" }
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup()
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim", },
            -- { "SmiteshP/nvim-navic" }
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({buffer = bufnr})

                -- if client.server_capabilities.documentSymbolProvider then
                --     require("nvim-navic").attach(client, bufnr)
                -- end
            end)

            require("mason-lspconfig").setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                            -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require("lspconfig").lua_ls.setup(lua_opts)
                    end,
                }
            })
        end
    }
    -- { "saadparwaiz1/cmp_luasnip" },
    -- { "rafamadriz/friendly-snippets" },
}
