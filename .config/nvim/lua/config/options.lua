vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.scrolloff = 10

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.wo.signcolumn = "yes"

vim.opt.termguicolors = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menu,menuone,noinsert"

-- Enable title upadtes
vim.opt.title = true
vim.opt.titlelen = 0 -- do not shorten title
--vim.opt.titlestring = "nvim %{expand("%:p")}"
