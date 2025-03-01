-- Install package manager (packer)
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

-- Plugin definitions
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'neovim/nvim-lspconfig' -- LSP configuration
  use 'hrsh7th/nvim-cmp' -- Completion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets
  use 'nvim-treesitter/nvim-treesitter' -- Better syntax highlighting
  use {
    'nvim-telescope/telescope.nvim', -- Fuzzy finder
    requires = { {'nvim-lua/plenary.nvim'}, 
                 {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'} -- Optional for better performance 
               }
  }
  use 'kyazdani42/nvim-tree.lua' -- File explorer
  use 'lewis6991/gitsigns.nvim' -- Git integration
  use 'preservim/nerdtree' -- File Tree
end)

-- Basic settings
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

-- Key mappings
vim.g.mapleader = ' ' -- Space as leader key
vim.api.nvim_set_keymap('n', '+', '$', { noremap = true, silent = true })
-- File explorer
vim.keymap.set('n', '<leader>e', ':NERDTreeToggle<CR>')
-- Telescope mappings
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
-- vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
-- vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)
-- vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)

-- Basic telescope setup
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"node_modules", ".git"},
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
  }
}

-- LSP setup would go here

