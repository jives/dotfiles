return {
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			{ "williamboman/mason-lspconfig.nvim", lazy = true },
			{ "j-hui/fidget.nvim", config = true },
			{ "folke/neodev.nvim", lazy = true },
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

					-- Buffer local mappings
					nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					nmap("<leader>ca", function()
						vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
					end, "[C]ode [A]ction")

					nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					nmap(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

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
				end,
			})

			require("neodev").setup()

			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
			lsp_capabilities =
				vim.tbl_deep_extend("force", lsp_capabilities, require("cmp_nvim_lsp").default_capabilities())

			local lspconfig = require("lspconfig")

			local default_setup = function(server)
				lspconfig[server].setup({
					capabilities = lsp_capabilities,
				})
			end

			-- Mason requires those to be called in this order
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"lua_ls",
					"stylua",
				},
				handlers = {
					default_setup,
					clangd = function()
						lspconfig.clangd.setup({
							capabilities = lsp_capabilities,
							keys = {
								{
									"<leader>cR",
									"<cmd>ClangdSwitchSourceHeader<cr>",
									desc = "Switch Source/Header (C/C++)",
								},
							},
							root_dir = function(fname)
								return require("lspconfig.util").root_pattern(
									"Makefile",
									"configure.ac",
									"configure.in",
									"config.h.in",
									"meson.build",
									"meson_options.txt",
									"build.ninja"
								)(fname) or require("lspconfig.util").root_pattern(
									"compile_commands.json",
									"compile_flags.txt"
								)(fname) or require("lspconfig.util").find_git_ancestor(fname)
							end,
							cmd = {
								"clangd",
								"--log=verbose",
								"--background-index",
								"--clang-tidy",
								"--header-insertion=iwyu",
								"--completion-style=detailed",
								"--function-arg-placeholders",
								"--fallback-style=llvm",
							},
							init_options = {
								usePlaceholders = true,
								completeUnimported = true,
								clangdFileStatus = true,
							},
						})
					end,
					lua_ls = function()
						lspconfig.lua_ls.setup({
							capabilities = lsp_capabilities,
							settings = {
								Lua = {
									runtime = { version = "LuaJIT" },
									workspace = {
										checkThirdParty = false,
										-- Tells lua_ls where to find all the Lua files that you have loaded
										-- for your neovim configuration.
										library = {
											"${3rd}/luv/library",
											unpack(vim.api.nvim_get_runtime_file("", true)),
										},
										-- If lua_ls is really slow on your computer, you can try this instead:
										-- library = { vim.env.VIMRUNTIME },
									},
									completion = {
										callSnippet = "Replace",
									},
									-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
									-- diagnostics = { disable = { 'missing-fields' } },
								},
							},
						})
					end,
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		config = true,
		lazy = true,
	},
}
