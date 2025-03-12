-- ~/.config/nvim/lua/user/config/telescope.lua
-- Telescope configuration

-- Telescope mappings
vim.api.nvim_set_keymap('n', '<leader>ff', ':lua require"telescope.builtin".find_files({ hidden = true })<CR>',
  { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)

-- Telescope NERDTree integration
function _G.telescope_find_from_nerdtree_root()
  -- Try to get NERDTree root directory
  local search_dir

  -- Check if NERDTree is available and loaded
  if vim.g.NERDTree ~= nil and vim.fn.exists("g:NERDTree.ForCurrentTab") == 1 then
    -- Get the NERDTree root path
    search_dir = vim.fn.eval("g:NERDTree.ForCurrentTab().getRoot().path.str()")
  else
    -- Fallback options if NERDTree root isn't available
    local current_file = vim.fn.expand("%:p")
    if current_file and current_file ~= "" then
      -- Get the directory containing the current file as fallback
      search_dir = vim.fn.fnamemodify(current_file, ":h")
    else
      -- Use current working directory as final fallback
      search_dir = vim.fn.getcwd()
    end
  end

  -- Use Telescope to find files from the determined directory
  require('telescope.builtin').find_files({
    cwd = search_dir,
  })
end

-- Current file directory search
function _G.telescope_find_from_current_file()
  -- Get the directory of the current file
  local current_file = vim.fn.expand("%:p")
  local current_dir

  if current_file and current_file ~= "" then
    -- Get the directory containing the current file
    current_dir = vim.fn.fnamemodify(current_file, ":h")

    -- Use Telescope to find files from this directory
    require('telescope.builtin').find_files({
      cwd = current_dir,
    })
  else
    -- Fallback to the default working directory if no file is open
    require('telescope.builtin').find_files()
  end
end

-- Set up the key mappings
vim.api.nvim_set_keymap('n', '<leader>fs', ':lua telescope_find_from_nerdtree_root()<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tf', ':lua telescope_find_from_current_file()<CR>',
  { noremap = true, silent = true })


-- Function to live grep from NERDTree root
function _G.telescope_grep_from_nerdtree_root()
  -- Try to get NERDTree root directory
  local search_dir

  -- Check if NERDTree is available and loaded
  if vim.g.NERDTree ~= nil and vim.fn.exists("g:NERDTree.ForCurrentTab") == 1 then
    -- Get the NERDTree root path
    search_dir = vim.fn.eval("g:NERDTree.ForCurrentTab().getRoot().path.str()")
  else
    -- Fallback options if NERDTree root isn't available
    local current_file = vim.fn.expand("%:p")
    if current_file and current_file ~= "" then
      -- Get the directory containing the current file as fallback
      search_dir = vim.fn.fnamemodify(current_file, ":h")
    else
      -- Use current working directory as final fallback
      search_dir = vim.fn.getcwd()
    end
  end

  -- Use Telescope to live grep from the determined directory
  require('telescope.builtin').live_grep({
    cwd = search_dir,
  })
end

-- Function to live grep from current file's directory
function _G.telescope_grep_from_current_file()
  -- Get the directory of the current file
  local current_file = vim.fn.expand("%:p")
  local current_dir

  if current_file and current_file ~= "" then
    -- Get the directory containing the current file
    current_dir = vim.fn.fnamemodify(current_file, ":h")

    -- Use Telescope to live grep from this directory
    require('telescope.builtin').live_grep({
      cwd = current_dir,
    })
  else
    -- Fallback to the default working directory if no file is open
    require('telescope.builtin').live_grep()
  end
end

-- Key mappings for the new functions
vim.api.nvim_set_keymap('n', '<leader>gs', ':lua telescope_grep_from_nerdtree_root()<CR>',
  { noremap = true, silent = true, desc = "Grep from NERDTree root" })
vim.api.nvim_set_keymap('n', '<leader>tg', ':lua telescope_grep_from_current_file()<CR>',
  { noremap = true, silent = true, desc = "Grep from current file directory" })


-- Basic telescope setup
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "node_modules", ".git", ".cache", ".idea", ".vscode", "__pycache__", ".venv", "miniconda3" },
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
    -- Change these options for better usability
    sorting_strategy = "ascending", -- Places results at the top
    layout_config = {
      prompt_position = "top",      -- Puts the search bar at the top
    }
  },
  extensions = {
    fzf_lua = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
    }
  }
}

-- Load the fzf extension after setup
require('telescope').load_extension('fzf')

