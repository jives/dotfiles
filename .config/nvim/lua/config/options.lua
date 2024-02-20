vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.scrolloff = 4

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.list = true
vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.wo.signcolumn = "yes"

vim.opt.termguicolors = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 500

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noselect"

-- Enable title upadtes
vim.opt.title = true
vim.opt.titlelen = 0 -- do not shorten title
--vim.opt.titlestring = "nvim %{expand("%:p")}"
