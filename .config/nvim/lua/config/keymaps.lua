vim.g.mapleader = " "
vim.g.localmapleader = " "

-- disable space in visual and normal mode
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- make CTRL + c behave exactly the same as ESC
vim.keymap.set("i", "<C-c>", "<ESC>")

-- close the current buffer
vim.keymap.set("n", "<C-x>", ":bd<CR>")

-- select entire file with CTRL + a
vim.keymap.set("n", "<C-a>", "ggVG")

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- indent and outdent lines quickly
vim.keymap.set("n", "<TAB>", ">>")
vim.keymap.set("n", "<S-TAB>", "<<")

-- indent and outdent lines in visual mode
vim.keymap.set("v", "<TAB>", "<S->>gv")
vim.keymap.set("v", "<S-TAB>", "<S-<>gv")

-- search movement keeps cursor in middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- unbind CTRL + d (its remapped below)
vim.keymap.set("n", "<C-d>", "<nop>")

-- vertical movement keeps cursor in middle
vim.keymap.set("n", "<C-j>", "<C-d>zz")
vim.keymap.set("n", "<C-k>", "<C-u>zz")

-- vertical movement keeps cursor in middle (visual mode)
vim.keymap.set("v", "<C-j>", "<C-d>zz")
vim.keymap.set("v", "<C-k>", "<C-u>zz")

-- move lines around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
