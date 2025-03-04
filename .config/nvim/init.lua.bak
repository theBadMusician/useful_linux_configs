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
  use { -- Git integration plugins
    'lewis6991/gitsigns.nvim',  -- Shows git changes in the gutter
    requires = {
      'nvim-lua/plenary.nvim'   -- Required dependency
    }
  }
  use 'preservim/nerdtree' -- File Tree
  use 'mbbill/undotree' -- Undo Tree
  use 'Mofiqul/vscode.nvim' -- VSCode Theme
  use {"adisen99/codeschool.nvim", requires = {"rktjmp/lush.nvim"}}
  use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }
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
vim.api.nvim_set_keymap('v', '+', '$', { noremap = true, silent = true })

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
  -- ignore_install = { "javascript" },

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


-- Undotree Configuration
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


-- Comment.nvim setup
require('Comment').setup({
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = 'gc',
        ---Block-comment keymap
        block = 'gb',
    },
    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
})


-- Colorscheme config
vim.o.background = "dark" -- or "light" for light mode

-- Load and setup function to choose plugin and language highlights
require('lush')(require('codeschool').setup({
  plugins = {
    "buftabline",
    "coc",
    "cmp", -- nvim-cmp
    "fzf",
    "gitgutter",
    "gitsigns",
    "lsp",
    "lspsaga",
    "nerdtree",
    "netrw",
    "nvimtree",
    "neogit",
    "packer",
    "signify",
    "startify",
    "syntastic",
    "telescope",
    "treesitter"
  },
  langs = {
    "c",
    "clojure",
    "coffeescript",
    "csharp",
    "css",
    "elixir",
    "golang",
    "haskell",
    "html",
    "java",
    "js",
    "json",
    "jsx",
    "lua",
    "markdown",
    "moonscript",
    "objc",
    "ocaml",
    "purescript",
    "python",
    "ruby",
    "rust",
    "scala",
    "typescript",
    "viml",
    "xml"
  }
}))
vim.g.codeschool_contrast_dark = "hard" -- Hard, medium, or soft

-- Make background darker
vim.cmd([[
  hi Normal guibg=#0a0a0a
  hi SignColumn guibg=#0a0a0a
  hi NormalFloat guibg=#0a0a0a
]])


-- Bufferline Colorscheme Setup
-- This function will be called after the colorscheme has been loaded
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Give it a slight delay to ensure it runs after colorscheme is fully loaded
    vim.defer_fn(function()
      -- Direct highlight overrides that won't be affected by the colorscheme
      vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "#073642" })
      vim.api.nvim_set_hl(0, "BufferLineBackground", { fg = "#657b83", bg = "#002b36" })
      vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#ffffff", bg = "#1a5fb4", bold = true, italic = true })
      vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { fg = "#839496", bg = "#073642" })
      vim.api.nvim_set_hl(0, "BufferLineSeparator", { fg = "#073642", bg = "#002b36" })
      vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { fg = "#073642", bg = "#1a5fb4" })
      vim.api.nvim_set_hl(0, "BufferLineSeparatorVisible", { fg = "#073642", bg = "#073642" })
      vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { fg = "#ff79c6", bg = "#1a5fb4" })
      vim.api.nvim_set_hl(0, "BufferLineModified", { fg = "#b58900" })
      vim.api.nvim_set_hl(0, "BufferLineModifiedSelected", { fg = "#ffff00", bg = "#1a5fb4", bold = true })
      vim.api.nvim_set_hl(0, "BufferLineModifiedVisible", { fg = "#b58900", bg = "#073642" })
      vim.api.nvim_set_hl(0, "BufferLineDuplicate", { fg = "#586e75", bg = "#002b36", italic = true })
      vim.api.nvim_set_hl(0, "BufferLineDuplicateSelected", { fg = "#ffffff", bg = "#1a5fb4", italic = true })
      vim.api.nvim_set_hl(0, "BufferLineTabSelected", { fg = "#ffffff", bg = "#1a5fb4", bold = true })
      
      -- Print confirmation message
      vim.notify("Bufferline highlights have been applied!", vim.log.levels.INFO)
    end, 100) -- 100ms delay
  end
})

-- Bufferline setup - Make this section for configuration only, not colors
vim.opt.termguicolors = true
require("bufferline").setup{
  options = {
    -- Enable close button
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    
    -- Separator style: 'slant' | 'thick' | 'thin' | { 'any', 'any' }
    separator_style = "thick",
    
    -- Show buffer numbers
    numbers = "ordinal",
    
    -- Use custom offset for the start of the bufferline
    offsets = {
      {
        filetype = "nerdtree",
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
    
    -- Add more spacing between tabs
    tab_size = 18,
    
    -- Make modified indicator more visible
    modified_icon = "●",
    
    -- Add indicator for active buffer
    indicator = {
      icon = '▎',
      style = 'icon',
    },
  }
}

-- Existing keymaps
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


-- Configure gitsigns.nvim
-- Define Git highlight groups
vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#009900' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#bbbb00' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#ff2222' })

vim.api.nvim_set_hl(0, 'GitSignsAddNr', { link = 'GitSignsAdd' })
vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { link = 'GitSignsChange' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { link = 'GitSignsDelete' })
vim.api.nvim_set_hl(0, 'GitSignsTopdeleteNr', { link = 'GitSignsDelete' })
vim.api.nvim_set_hl(0, 'GitSignsChangedeleteNr', { link = 'GitSignsChange' })

vim.api.nvim_set_hl(0, 'GitSignsAddLn', { bg = '#103510' })
vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { bg = '#353510' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { bg = '#351515' })
vim.api.nvim_set_hl(0, 'GitSignsTopdeleteLn', { link = 'GitSignsDeleteLn' })
vim.api.nvim_set_hl(0, 'GitSignsChangedeleteLn', { link = 'GitSignsChangeLn' })

-- Configure gitsigns.nvim
require('gitsigns').setup({
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
  },
  -- Configure git update events
  watch_gitdir = {
    interval = 1000,  -- Check for git changes every 1000ms
    follow_files = true
  },
  -- Display git diff on the sign column
  signcolumn = true,
  -- Update diff on file change
  update_debounce = 100,
  -- Attach to untracked files
  attach_to_untracked = true,
  -- Optional: status line integration
  status_formatter = nil,
  -- Optional: keymaps for git operations
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)
  end
})

-- Direct function with minimal complexity
local function telescope_git_command(command)
  -- Get current directory of the file
  local current_file = vim.fn.expand('%:p')
  local current_dir = vim.fn.fnamemodify(current_file, ':h')
  
  -- Save current directory
  local original_cwd = vim.fn.getcwd()
  
  -- Change to the file's directory first
  vim.cmd('cd ' .. vim.fn.fnameescape(current_dir))
  
  -- Now try to find git root from here
  local git_root = vim.fn.system('git rev-parse --show-toplevel 2>/dev/null')
  git_root = vim.fn.trim(git_root)
  
  if git_root ~= "" then
    -- Change to git root
    vim.cmd('cd ' .. vim.fn.fnameescape(git_root))
    
    -- Run the telescope command directly with pcall
    local status, _ = pcall(function()
      vim.cmd('Telescope ' .. command)
    end)
    
    if not status then
      print("Error running git command: make sure you're in a git repository")
    end
  else
    print("Not in a git repository")
  end
  
  -- Return to original directory
  vim.cmd('cd ' .. vim.fn.fnameescape(original_cwd))
end

-- Set keymaps with simplified approach
vim.keymap.set('n', '<leader>vc', function() telescope_git_command('git_commits') end, {desc = "Git commits"})
vim.keymap.set('n', '<leader>vb', function() telescope_git_command('git_branches') end, {desc = "Git branches"})
vim.keymap.set('n', '<leader>vs', function() telescope_git_command('git_status') end, {desc = "Git status"})

-- Debug command to test telescope directly
vim.keymap.set('n', '<leader>vt', function()
  local ok = pcall(function() 
    vim.cmd('Telescope find_files')
  end)
  if not ok then
    print("Telescope error - check if telescope is properly installed")
  end
end, {desc = "Git Telescope integration"})

-- -- Add keymaps for telescope git commav
-- --ds with smart directory handling
-- vim.api.nvim_set_keymap('n', '<leader>vc', "<cmd>lua telescope_git_command('git_commits')<CR>", {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>vb', "<cmd>lua telescope_git_command('git_branches')<CR>", {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>vs', "<cmd>lua telescope_git_command('git_status')<CR>", {noremap = true, silent = true})


-- LSP setup would go here
