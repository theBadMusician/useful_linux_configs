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

-- For normal mode delete operations
vim.keymap.set('n', 'x', '"_x')    -- Delete character under cursor
vim.keymap.set('n', 'X', '"_X')    -- Delete character before cursor
vim.keymap.set('n', 'd', '"_d')    -- Delete operator
vim.keymap.set('n', 'D', '"_D')    -- Delete to end of line
vim.keymap.set('n', 'dd', '"_dd')  -- Delete line
vim.keymap.set('n', 'c', '"_c')    -- Change operator
vim.keymap.set('n', 'C', '"_C')    -- Change to end of line
vim.keymap.set('n', 'cc', '"_cc')  -- Change line

-- For visual mode delete operations
vim.keymap.set('v', 'x', '"_x')    -- Delete selected text
vim.keymap.set('v', 'd', '"_d')    -- Delete selected text
vim.keymap.set('v', 'D', '"_D')    -- Delete to end of line on selected lines
vim.keymap.set('v', 'c', '"_c')    -- Change selected text
vim.keymap.set('v', 'C', '"_C')    -- Change to end of line on selected lines

--> Tabbing multiple lines <--
-- Shift selected lines right with Tab
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', { noremap = true, silent = true })
-- Shift selected lines left with Shift+Tab
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', { noremap = true, silent = true })


