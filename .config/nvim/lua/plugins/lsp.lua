return {
    {
        "neovim/nvim-lspconfig",
        cmd = {"LspInfo", "LspInstall", "LspStart"},
        event = {"BufReadPre", "BufNewFile"},
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            -- { "j-hui/fidget.nvim", opts = {} },
            "folke/neodev.nvim",
            { "folke/neoconf.nvim", cmd = "Neoconf", config = true, dependencies = { "nvim-lspconfig" } },
        },
        config = function(_, opts)
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP Actions",
                callback = function(event)
                    local nmap = function(keys, func, desc)
                        if desc then
                            desc = "LSP: " .. desc
                        end

                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
                    end

                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings
                    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    nmap("<leader>ca", function()
                        vim.lsp.buf.code_action { context = { only = { "quickfix", "refactor", "source" } } }
                    end, "[C]ode [A]ction")

                    nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                    nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

                    -- See `:help K` for why this keymap
                    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

                    -- Lesser used LSP functionality
                    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
                    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
                    nmap("<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, "[W]orkspace [L]ist Folders")

                    -- Create a command `:Format` local to the LSP buffer
                    vim.api.nvim_buf_create_user_command(event.buf, "Format", function(_)
                        vim.lsp.buf.format()
                    end, { desc = "Format current buffer with LSP" })
                end
            })

            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            local default_setup = function(server)
                require('lspconfig')[server].setup({
                    capabilities = lsp_capabilities,
                })
            end

            -- Mason requires those to be called in this order
            -- require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    default_setup,
                },
            })
        end
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        config = true
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "saadparwaiz1/cmp_luasnip",
                -- Adds LSP completion capabilities
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
            },
        },
        config = function ()
            require("cmp").setup {
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },

                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                },
            }
        end
    },
    {
        "L3MON4D3/LuaSnip",
        build = (function()
            -- Build Step is needed for (optional) regex support in snippets
            -- This step is not supported in many windows environments
            if vim.fn.has "win32" == 1 then
                return
            end
            return "make install_jsregexp"
        end)(),
        dependencies = {
            {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        }
    }
}
