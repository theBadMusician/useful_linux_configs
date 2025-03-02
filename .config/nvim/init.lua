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
  use 'mbbill/undotree' -- Undo Tree
  use 'Mofiqul/vscode.nvim' -- VSCode Theme
  use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
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
vim.opt.encoding = 'UTF-8'

-- Key mappings
vim.g.mapleader = ' ' -- Space as leader key
vim.api.nvim_set_keymap('n', '+', '$', { noremap = true, silent = true })

-- Jump multiple lines using <C-j> and <C-k> (Ctrl+j and Ctrl+k)
vim.api.nvim_set_keymap('n', '<C-j>', '20j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '20k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-j>', '20j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-k>', '20k', { noremap = true, silent = true })

-- File explorer
vim.keymap.set('n', '<leader>e', ':NERDTreeToggle<CR>')

-- Define command to save and source using single motion
vim.api.nvim_create_user_command('SaveAndSource', function()
  vim.cmd('write')
  vim.cmd('source %')
  vim.notify('File saved and sourced!', vim.log.levels.INFO)
end, {})
vim.keymap.set('n', '<leader>ss', ':SaveAndSource<CR>', { noremap = true, silent = true })


-- Telescope mappings
vim.api.nvim_set_keymap('n', '<leader>ff', ':lua require"telescope.builtin".find_files({ hidden = true })<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)

-- Basic telescope setup
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"node_modules", ".git"},
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        -- Add a custom mapping to select the first entry when you press Enter
        ["<CR>"] = function(bufnr)
          require('telescope.actions').select_default(bufnr)
        end
      },
    },
    -- Change these options for better usability
    sorting_strategy = "ascending", -- Places results at the top
    layout_config = {
      prompt_position = "top", -- Puts the search bar at the top
    }
  }
}

-- Select the first item automatically
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  group = telescope_select_first,
  callback = function()
    vim.api.nvim_create_autocmd("TextChangedI", {
      buffer = 0,
      group = telescope_select_first,
      callback = function()
        -- Use pcall to prevent errors if the operation fails
        pcall(function()
          -- First check if there are results
          local win = vim.api.nvim_get_current_win()
          local results_win = vim.fn.bufwinid("TelescopeResults")
          if results_win ~= -1 then
            -- Save current window and move to results window
            local current_win = vim.api.nvim_get_current_win()
            vim.api.nvim_set_current_win(results_win)
            -- Move to the first line and restore window
            vim.cmd("normal! gg")
            vim.api.nvim_set_current_win(current_win)
          end
        end)
      end
    })
  end
})


-- Treesitter config
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "python", "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- undotree setup
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)


-- NERDTree config
-- Open NERDTree automatically when vim starts up with no files specified
vim.api.nvim_create_autocmd("StdinReadPre", {
  callback = function()
    vim.g.std_in = 1
  end
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.g.std_in == nil then
      vim.cmd("NERDTree")
      vim.cmd("wincmd p")  -- Move cursor to the previous (last accessed) window
    end
  end
})

-- Show hidden files by default
vim.g.NERDTreeShowHidden = 1

-- Ignore certain files and directories
vim.g.NERDTreeIgnore = {"\\.git$", "node_modules$", "\\.DS_Store$"}

-- Set width of NERDTree window
vim.g.NERDTreeWinSize = 30

-- Show line numbers in NERDTree
vim.g.NERDTreeShowLineNumbers = 1

-- Make it prettier
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeDirArrows = 1

-- Keymapping suggestion
vim.keymap.set('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>nf', ':NERDTreeFind<CR>', { noremap = true, silent = true })
-- Create an autocmd to ensure the mappings work in NERDTree specifically
vim.api.nvim_create_autocmd("FileType", {
  pattern = "nerdtree",
  callback = function()
    local opts = { noremap = true, silent = true }
    -- 0 refers to the current buffer
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-j>', '20j', opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-k>', '20k', opts)
  end
})

-- Bufferline setup
vim.opt.termguicolors = true
require("bufferline").setup{
  options = {
    -- Enable close button
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    
    -- Separator style: 'slant' | 'thick' | 'thin' | { 'any', 'any' }
    separator_style = "thin",
    
    -- Add indicators for modified files, etc.
    -- diagnostics = "nvim_lsp",
    
    -- Show buffer numbers
    numbers = "ordinal",
    
    -- Use custom offset for the start of the bufferline
    offsets = {
      {
        filetype = "NERDTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center"
      }
    },
    
    -- Show the buffer name in the tab
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    
    -- Enforce regular buffer switching
    enforce_regular_tabs = false,
    
    -- Always show tabs
    always_show_bufferline = true,
  }
}

vim.api.nvim_set_keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>x', ':bdelete<CR>', { noremap = true, silent = true })
-- Move buffer tabs
vim.api.nvim_set_keymap('n', '<leader>bn', ':BufferLineMoveNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bp', ':BufferLineMovePrev<CR>', { noremap = true, silent = true })
-- Go to buffer by number
vim.api.nvim_set_keymap('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>4', ':BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>5', ':BufferLineGoToBuffer 5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>6', ':BufferLineGoToBuffer 6<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>7', ':BufferLineGoToBuffer 7<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>8', ':BufferLineGoToBuffer 8<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>9', ':BufferLineGoToBuffer 9<CR>', { noremap = true, silent = true })


-- vscode.nvim config
-- require("bufferline").setup({
--     options = {
--         buffer_close_icon = "",
--         close_command = "bdelete %d",
--         close_icon = "",
--         indicator = {
--           style = "icon",
--           icon = " ",
--         },
--         left_trunc_marker = "",
--         modified_icon = "●",
--         offsets = { { filetype = "NvimTree", text = "EXPLORER", text_align = "center" } },
--         right_mouse_command = "bdelete! %d",
--         right_trunc_marker = "",
--         show_close_icon = false,
--         show_tab_indicators = true,
--     },
--     highlights = {
--         fill = {
--             fg = { attribute = "fg", highlight = "Normal" },
--             bg = { attribute = "bg", highlight = "StatusLineNC" },
--         },
--         background = {
--             fg = { attribute = "fg", highlight = "Normal" },
--             bg = { attribute = "bg", highlight = "StatusLine" },
--         },
--         buffer_visible = {
--             fg = { attribute = "fg", highlight = "Normal" },
--             bg = { attribute = "bg", highlight = "Normal" },
--         },
--         buffer_selected = {
--             fg = { attribute = "fg", highlight = "Normal" },
--             bg = { attribute = "bg", highlight = "Normal" },
--         },
--         separator = {
--             fg = { attribute = "bg", highlight = "Normal" },
--             bg = { attribute = "bg", highlight = "StatusLine" },
--         },
--         separator_selected = {
--             fg = { attribute = "fg", highlight = "Special" },
--             bg = { attribute = "bg", highlight = "Normal" },
--         },
--         separator_visible = {
--             fg = { attribute = "fg", highlight = "Normal" },
--             bg = { attribute = "bg", highlight = "StatusLineNC" },
--         },
--         close_button = {
--             fg = { attribute = "fg", highlight = "Normal" },
--             bg = { attribute = "bg", highlight = "StatusLine" },
--         },
--         close_button_selected = {
--             fg = { attribute = "fg", highlight = "Normal" },
--             bg = { attribute = "bg", highlight = "Normal" },
--         },
--         close_button_visible = {
--             fg = { attribute = "fg", highlight = "Normal" },
--             bg = { attribute = "bg", highlight = "Normal" },
--         },
--     },
-- })

-- LSP setup would go here
