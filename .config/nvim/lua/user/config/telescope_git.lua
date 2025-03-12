-- ~/.config/nvim/lua/config/telescope_git.lua
-- Telescope Git Integration

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
vim.keymap.set('n', '<leader>vc', function() telescope_git_command('git_commits') end, { desc = "Git commits" })
vim.keymap.set('n', '<leader>vb', function() telescope_git_command('git_branches') end, { desc = "Git branches" })
vim.keymap.set('n', '<leader>vs', function() telescope_git_command('git_status') end, { desc = "Git status" })

-- Debug command to test telescope directly
vim.keymap.set('n', '<leader>vt', function()
  local ok = pcall(function()
    vim.cmd('Telescope find_files')
  end)
  if not ok then
    print("Telescope error - check if telescope is properly installed")
  end
end, { desc = "Git Telescope integration" })
