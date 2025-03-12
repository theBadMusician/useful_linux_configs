-- ~/.config/nvim/lua/config/gitsigns.lua
-- Gitsigns Configuration

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
    interval = 1000, -- Check for git changes every 1000ms
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
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line { full = true } end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)
  end
})
