-- Disable nvim intro
vim.opt.shortmess:append "sI"

-- General settings
vim.opt.clipboard = 'unnamedplus'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.mouse = 'a'
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.swapfile = false
vim.opt.updatetime = 300

-- UI settings
vim.opt.termguicolors = true
vim.opt.foldmethod = 'marker'
vim.opt.showmatch = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.laststatus = 3

-- Tabs and indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Memory, CPU
vim.opt.hidden = true
vim.opt.history = 100
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 240
vim.opt.updatetime = 250

-- Keybindings
vim.keymap.set('n', '<Leader><space>', ':noh<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>n', ':set nu! rnu!<CR>', { noremap = true, silent = true })

-- Load plugins
require('plugins')

-- Defer plugin configurations until after installation
vim.api.nvim_create_autocmd("User", {
  pattern = "PackerComplete",
  callback = function()
    require('plugin_config')
  end
})