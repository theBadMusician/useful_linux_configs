-- ~/.config/nvim/lua/options.lua
-- Basic Vim options

-- Editor behavior
vim.opt.number = true
vim.opt.relativenumber = false

-- Tabs as spaces with 2 spaces per tab
-- vim.opt.expandtab = true
-- vim.opt.shiftwidth = 2
-- vim.opt.tabstop = 2

-- Tabs as actual tabs with a width of 4 spaces
vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.scrolloff = 8
vim.opt.updatetime = 300
vim.opt.mouse = 'a'
vim.opt.modeline = false

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

-- Apply specific settings only for LaTeX files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex", "plaintex", "md" },
  callback = function()
    -- Enable soft wrapping
    vim.opt_local.wrap = true

    -- Wrap at whole words, not in the middle of a word
    vim.opt_local.linebreak = true

    -- Preserve indentation on wrapped lines
    vim.opt_local.breakindent = true

    -- Map j and k to move down/up visual lines instead of logical lines
    local opts = { buffer = true, noremap = true, silent = true }
    vim.keymap.set('n', 'j', 'gj', opts)
    vim.keymap.set('n', 'k', 'gk', opts)

    -- Also handle visual mode
    vim.keymap.set('v', 'j', 'gj', opts)
    vim.keymap.set('v', 'k', 'gk', opts)
  end,
})
