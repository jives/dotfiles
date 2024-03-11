vim.g.mapleader = " "
vim.g.localmapleader = " "

-- disable space in visual and normal mode
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- make CTRL + c behave exactly the same as ESC
vim.keymap.set("i", "<C-c>", "<ESC>")

-- close the current buffer
vim.keymap.set("n", "<C-x>", ":bd<CR>", { desc = "Delete current buffer" })

-- select entire file with CTRL + a
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- indent and outdent lines quickly
vim.keymap.set("n", "<TAB>", ">>", { desc = "Indent line" })
vim.keymap.set("n", "<S-TAB>", "<<", { desc = "Outdent line" })

-- indent and outdent lines in visual mode
vim.keymap.set("v", "<TAB>", "<S->>gv")
vim.keymap.set("v", "<S-TAB>", "<S-<>gv")

-- search movement keeps cursor in middle
vim.keymap.set("n", "n", "nzzzv", { desc = "Next match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous match" })

-- unbind CTRL + d (its remapped below)
vim.keymap.set("n", "<C-d>", "<nop>")

-- vertical movement keeps cursor in middle
vim.keymap.set("n", "<C-j>", "<C-d>zz", { desc = "Half page down" })
vim.keymap.set("n", "<C-k>", "<C-u>zz", { desc = "Half page up" })

-- vertical movement keeps cursor in middle (visual mode)
vim.keymap.set("v", "<C-j>", "<C-d>zz")
vim.keymap.set("v", "<C-k>", "<C-u>zz")

-- move lines around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic Error messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
