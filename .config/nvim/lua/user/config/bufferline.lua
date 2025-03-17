-- ~/.config/nvim/lua/config/bufferline.lua
-- Bufferline Configuration

-- Bufferline setup - configuration only, not colors
require("bufferline").setup {
  options = {
    -- Enable close button
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",

    -- Separator style: 'slant' | 'thick' | 'thin' | { 'any', 'any' }
    separator_style = "slant",
    -- separator_style = "thick",


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



-- Function to apply bufferline highlights that won't be overridden
local function apply_bufferline_highlights()
  -- Direct vim.cmd calls for more reliable highlight application
  vim.cmd([[
    highlight! BufferLineFill guibg=#000000
    highlight! BufferLineBackground guifg=#657b83 guibg=#000000
    highlight! BufferLineBufferSelected guifg=#ffffff guibg=#000000 gui=bold,italic
    highlight! BufferLineBufferVisible guifg=#839496 guibg=#000000 
    highlight! BufferLineSeparator guifg=#928e85 guibg=#000000
    highlight! BufferLineSeparatorSelected guifg=#ff0000 guibg=#000000
    highlight! BufferLineSeparatorVisible guifg=#ff0000 guibg=#000000
    highlight! BufferLineIndicatorSelected guifg=#000000 guibg=#000000
    highlight! BufferLineModified guifg=#000000 guibg=#000000
    highlight! BufferLineModifiedSelected guifg=#ffff00 guibg=#000000 gui=bold
    highlight! BufferLineModifiedVisible guifg=#000000 guibg=#000000
    highlight! BufferLineDuplicate guifg=#000000 guibg=#000000 gui=italic
    highlight! BufferLineDuplicateSelected guifg=#ffffff guibg=#000000 gui=italic
    highlight! BufferLineTabSelected guifg=#ffffff guibg=#000000 gui=bold
    
    " Add these highlights for numbers and close icons
    highlight! BufferLineNumbers guifg=#ffffff guibg=#000000
    highlight! BufferLineNumbersSelected guifg=#ffffff guibg=#000000 gui=bold
    highlight! BufferLineNumbersVisible guifg=#839496 guibg=#000000
    
    " Close button highlights
    highlight! BufferLineCloseButton guifg=#ffffff guibg=#000000
    highlight! BufferLineCloseButtonSelected guifg=#ffffff guibg=#000000
    highlight! BufferLineCloseButtonVisible guifg=#839496 guibg=#000000
  ]])
  vim.notify("Bufferline highlights applied forcefully!", vim.log.levels.INFO)
end

-- Create an autocommand group for our bufferline highlights
local bufferline_augroup = vim.api.nvim_create_augroup("BufferlineHighlights", { clear = true })

-- Ensure our highlights run after VimEnter (when everything is loaded)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Delay slightly to ensure it runs after everything else
    vim.defer_fn(apply_bufferline_highlights, 200)
  end,
  group = bufferline_augroup,
})

-- Also run when colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Delay to run after colorscheme fully applies
    vim.defer_fn(apply_bufferline_highlights, 1000)
  end,
  group = bufferline_augroup,
})

-- Apply immediately as well
apply_bufferline_highlights()

