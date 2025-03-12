-- ~/.config/nvim/lua/config/bufferline.lua
-- Bufferline Configuration

-- Bufferline setup - configuration only, not colors
require("bufferline").setup {
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

-- Keymaps
-- vim.api.nvim_set_keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>x', ':bp|bd #<CR>', { noremap = true, silent = true })
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
