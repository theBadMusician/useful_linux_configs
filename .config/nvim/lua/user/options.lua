-- ~/.config/nvim/lua/options.lua
-- Basic Vim options

-- Editor behavior
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.scrolloff = 8
vim.opt.updatetime = 300
vim.opt.mouse = 'a'

-- File handling
vim.opt.encoding = 'UTF-8'

-- Search behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Required for certain plugins
vim.opt.termguicolors = true

-- Configure diagnostics appearance
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
