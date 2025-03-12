-- ~/.config/nvim/lua/user/plugins.lua
-- Plugin definitions using Packer

local utils = require('user.utils')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Core plugins
  use 'nvim-treesitter/nvim-treesitter' -- Better syntax highlighting
  use {
    'nvim-telescope/telescope.nvim',    -- Fuzzy finder
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- Optional for better performance
    }
  }

  -- File navigation
  use 'kyazdani42/nvim-tree.lua' -- File explorer
  use 'preservim/nerdtree'       -- File Tree
  use 'mbbill/undotree'          -- Undo Tree

  -- Git integration
  use {
    'lewis6991/gitsigns.nvim', -- Shows git changes in the gutter
    requires = {
      'nvim-lua/plenary.nvim'  -- Required dependency
    }
  }

  -- UI enhancements
  use 'Mofiqul/vscode.nvim' -- VSCode Theme
  use {
    "adisen99/codeschool.nvim",
    requires = { "rktjmp/lush.nvim" }
  }
  use {
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = 'nvim-tree/nvim-web-devicons'
  }

  -- Editing enhancements
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Copilot for inline code suggestions
  use 'github/copilot.vim'

  -- LSP and completion
  use 'neovim/nvim-lspconfig'             -- LSP configuration
  use 'hrsh7th/nvim-cmp'                  -- Completion plugin
  use 'hrsh7th/cmp-nvim-lsp'              -- LSP source for nvim-cmp
  use 'L3MON4D3/LuaSnip'                  -- Snippets
  use 'saadparwaiz1/cmp_luasnip'          -- LuaSnip completion source for nvim-cmp
  use 'hrsh7th/cmp-buffer'                -- Buffer completion source
  use 'hrsh7th/cmp-path'                  -- Path completion source
  use 'williamboman/mason.nvim'           -- Package manager for LSP servers
  use 'williamboman/mason-lspconfig.nvim' -- Bridge between mason and lspconfig
  use 'folke/lsp-colors.nvim'             -- LSP color highlighting

  -- Automatically set up your configuration after cloning packer.nvim
  if utils.packer_bootstrap then
    require('packer').sync()
  end
end)
