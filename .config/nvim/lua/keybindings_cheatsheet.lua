-- keybindings_cheatsheet.lua
local M = {}

function M.setup()
  -- Function to open keybindings cheatsheet in a sidebar
  function _G.open_keybindings_cheatsheet()
    -- Path to the cheatsheet file - replace this with your actual path
    local cheatsheet_path = vim.fn.stdpath('config') .. '/keybindings-cheatsheet.md'

    -- Create the cheatsheet file if it doesn't exist
    if vim.fn.filereadable(cheatsheet_path) == 0 then
      -- Content of the cheatsheet - this is what we generated earlier
      local cheatsheet_content = [[# Neovim Key Bindings Cheat Sheet

## General Navigation
| Keybinding | Mode | Description |
|------------|------|-------------|
| `<Space>` | - | Leader key |
| `+` | Normal, Visual | Go to end of line (same as `$`) |
| `<C-j>` | Normal, Visual | Jump 20 lines down |
| `<C-k>` | Normal, Visual | Jump 20 lines up |
| `<C-l>` | Normal, Visual | Jump 3 words forward |
| `<C-h>` | Normal, Visual | Jump 3 words backward |

## File Navigation & Management
| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>e` | Normal | Toggle NERDTree file explorer |
| `<C-n>` | Normal | Toggle NERDTree file explorer (alternative) |
| `<leader>nf` | Normal | Find current file in NERDTree |
| `<leader>ss` | Normal | Save and source current file |

## Telescope (Fuzzy Finder)
| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>ff` | Normal | Find files (including hidden) |
| `<leader>fb` | Normal | Find open buffers |
| `<leader>fg` | Normal | Live grep (search for text) |
| `<leader>fh` | Normal | Search help tags |

## Git Integration
| Keybinding | Mode | Description |
|------------|------|-------------|
| `]c` | Normal | Go to next git hunk |
| `[c` | Normal | Go to previous git hunk |
| `<leader>hs` | Normal | Stage hunk |
| `<leader>hr` | Normal | Reset hunk |
| `<leader>hs` | Visual | Stage selected lines |
| `<leader>hr` | Visual | Reset selected lines |
| `<leader>hS` | Normal | Stage entire buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hR` | Normal | Reset entire buffer |
| `<leader>hp` | Normal | Preview hunk |
| `<leader>hb` | Normal | Blame line (full) |
| `<leader>tb` | Normal | Toggle current line blame |
| `<leader>hd` | Normal | Show diff |
| `<leader>hD` | Normal | Show diff against ~1 |
| `<leader>td` | Normal | Toggle deleted hunks |
| `<leader>vc` | Normal | Browse git commits (Telescope) |
| `<leader>vb` | Normal | Browse git branches (Telescope) |
| `<leader>vs` | Normal | View git status (Telescope) |
| `<leader>vt` | Normal | Test Telescope integration |

## Buffer Navigation
| Keybinding | Mode | Description |
|------------|------|-------------|
| `<Tab>` | Normal | Go to next buffer |
| `<S-Tab>` | Normal | Go to previous buffer |
| `<leader>x` | Normal | Close current buffer |
| `<leader>bn` | Normal | Move buffer to next position |
| `<leader>bp` | Normal | Move buffer to previous position |
| `<leader>1-9` | Normal | Go to buffer by number (1-9) |

## Code Editing
| Keybinding | Mode | Description |
|------------|------|-------------|
| `gcc` | Normal | Toggle line comment |
| `gbc` | Normal | Toggle block comment |
| `gc` | Normal, Visual | Comment operator (followed by motion) |
| `gb` | Normal, Visual | Block comment operator |
| `gcO` | Normal | Add comment on line above |
| `gco` | Normal | Add comment on line below |
| `gcA` | Normal | Add comment at end of line |

## Undo Tree
| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>u` | Normal | Toggle Undo tree |

## LSP (Language Server Protocol)
| Keybinding | Mode | Description |
|------------|------|-------------|
| `gD` | Normal | Go to declaration |
| `gd` | Normal | Go to definition |
| `K` | Normal | Show hover information |
| `gi` | Normal | Go to implementation |
| `<leader>ws` | Normal | Show signature help |
| `<leader>wa` | Normal | Add workspace folder |
| `<leader>wr` | Normal | Remove workspace folder |
| `<leader>wl` | Normal | List workspace folders |
| `<leader>D` | Normal | Go to type definition |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal | Code action |
| `gr` | Normal | Find references |
| `<leader>f` | Normal | Format buffer |

## Diagnostics
| Keybinding | Mode | Description |
|------------|------|-------------|
| `<space>w` | Normal | Show diagnostics in float window |
| `[d` | Normal | Go to previous diagnostic |
| `]d` | Normal | Go to next diagnostic |
| `<space>q` | Normal | Send diagnostics to location list |
| `<leader>td` | Normal | Toggle diagnostics on/off |

## Completion
| Keybinding | Mode | Description |
|------------|------|-------------|
| `<C-d>` | Insert | Scroll docs down |
| `<C-f>` | Insert | Scroll docs up |
| `<C-Space>` | Insert | Trigger completion |
| `<CR>` | Insert | Confirm completion |
| `<Tab>` | Insert | Next completion item |
| `<S-Tab>` | Insert | Previous completion item |

## Keybindings Cheatsheet
| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>kc` | Normal | Open this keybindings cheatsheet |]]

      -- Write the cheatsheet to file
      local file = io.open(cheatsheet_path, "w")
      if file then
        file:write(cheatsheet_content)
        file:close()
        vim.notify("Keybindings cheatsheet created at " .. cheatsheet_path)
      else
        vim.notify("Failed to create cheatsheet file at " .. cheatsheet_path, vim.log.levels.ERROR)
        return
      end
    end

    -- Check if there's already a cheatsheet window open
    local cheatsheet_open = false
    for _, win in pairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local buf_name = vim.api.nvim_buf_get_name(buf)
      if buf_name:match("keybindings%-cheatsheet%.md$") then
        -- Focus on the existing window
        vim.api.nvim_set_current_win(win)
        cheatsheet_open = true
        break
      end
    end

    if not cheatsheet_open then
      -- Save current window to return to it later
      local current_win = vim.api.nvim_get_current_win()

      -- Create a vertical split on the right
      vim.cmd('vsplit ' .. cheatsheet_path)

      -- Get the new window and configure it
      local cheatsheet_win = vim.api.nvim_get_current_win()

      -- Set the width of the cheatsheet window to 60 columns
      vim.api.nvim_win_set_width(cheatsheet_win, 60)

      -- Configure it to be a sidebar-like window
      vim.api.nvim_win_set_option(cheatsheet_win, 'number', false)
      vim.api.nvim_win_set_option(cheatsheet_win, 'relativenumber', false)
      vim.api.nvim_win_set_option(cheatsheet_win, 'cursorline', true)
      vim.api.nvim_win_set_option(cheatsheet_win, 'signcolumn', 'no')

      -- Set it to read-only
      local buf = vim.api.nvim_win_get_buf(cheatsheet_win)
      vim.api.nvim_buf_set_option(buf, 'modifiable', false)
      vim.api.nvim_buf_set_option(buf, 'readonly', true)

      -- Return to the original window
      vim.api.nvim_set_current_win(current_win)

      -- Create a keybinding to close the cheatsheet
      vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':q<CR>', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':q<CR>', { noremap = true, silent = true })
    end
  end

  -- Add a keymap to toggle the cheatsheet
  vim.api.nvim_set_keymap('n', '<leader>kc', ':lua open_keybindings_cheatsheet()<CR>', { noremap = true, silent = true })

  -- Command to open the cheatsheet
  vim.api.nvim_create_user_command('Keybindings', 'lua open_keybindings_cheatsheet()', {})
end

return M
