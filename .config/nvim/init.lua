-- ~/.config/nvim/init.lua
-- Main entry point for Neovim configuration

-- Install packer automatically if it's not installed
require('user.utils') -- Load utility functions first

-- Load core configuration
require('user.plugins')  -- Plugin definitions with packer
require('user.options')  -- Basic vim options
require('user.keymaps')  -- General key mappings

-- Load plugin configurations
require('user.config.telescope')
require('user.config.treesitter')
require('user.config.nerdtree')
require('user.config.undotree')
require('user.config.bufferline')
require('user.config.gitsigns')
require('user.config.comment')
require('user.config.telescope_git')

-- Load LSP configuration
require('user.lsp')

-- Load colorscheme after everything else
require('user.colorscheme')

-- Load bufferline configuration again to override colorscheme
require('user.config.bufferline')

-- Load keybindings cheatsheet
require('user.keybindings_cheatsheet').setup()

-- Automatically compile plugins when this file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Print a confirmation message
vim.notify("Neovim configuration loaded successfully!", vim.log.levels.INFO)
