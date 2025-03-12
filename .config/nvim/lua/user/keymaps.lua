-- ~/.config/nvim/lua/keymaps.lua
-- General key mappings

-- Set leader key to space
vim.g.mapleader = ' '

-- Normal mode mappings
-- Navigation shortcuts
vim.api.nvim_set_keymap('n', '+', '$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '20j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '20k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '3w', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '3b', { noremap = true, silent = true })

-- Save file
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

-- Select all
vim.api.nvim_set_keymap('n', '<C-q>', 'ggVG', { noremap = true, silent = true })

-- Undo/Redo
vim.api.nvim_set_keymap('n', '<C-z>', 'u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-M-Z>', '<C-r>', { noremap = true, silent = true })

-- Window navigation
vim.api.nvim_set_keymap('n', '<C-e>', '<C-w>w', { noremap = true, silent = true })

-- Visual mode mappings
vim.api.nvim_set_keymap('v', '+', '$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-j>', '20j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-k>', '20k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-l>', '3w', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-h>', '3b', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-q>', '<Esc>ggVG', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-z>', '<Esc>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-M-Z>', '<Esc><C-r>', { noremap = true, silent = true })

-- Insert mode mappings
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-q>', '<Esc>ggVG', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-z>', '<Esc>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-M-Z>', '<Esc><C-r>', { noremap = true, silent = true })

-- File explorer
vim.keymap.set('n', '<leader>e', ':NERDTreeToggle<CR>')

-- Custom commands
vim.keymap.set('n', '<leader>ss', ':SaveAndSource<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rr', ':ReloadConfig<CR>', { noremap = true, silent = true, desc = 'Reload Neovim config' })

-- Diagnostics navigation
vim.keymap.set('n', '<space>w', vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>td', toggle_diagnostics, { noremap = true, silent = true })

-- Execute current file
vim.keymap.set('n', '<leader>r', execute_file, { noremap = true, silent = true, desc = 'Execute current file from NERDTree root' })
