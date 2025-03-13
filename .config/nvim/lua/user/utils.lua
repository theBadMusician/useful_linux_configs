-- ~/.config/nvim/lua/user/utils.lua
-- Utility functions for Neovim configuration

local M = {}

-- Install package manager (packer) if not already installed
local function ensure_packer()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Define command to save and source using single motion
vim.api.nvim_create_user_command('SaveAndSource', function()
  vim.cmd('write')
  vim.cmd('source %')
  vim.notify('File saved and sourced!', vim.log.levels.INFO)
end, {})

-- Define command to reload the entire init.lua configuration
vim.api.nvim_create_user_command('ReloadConfig', function()
  vim.cmd('source ' .. vim.fn.stdpath('config') .. '/init.lua')
  vim.notify('Neovim configuration reloaded!', vim.log.levels.INFO)
end, {})

-- Toggle diagnostics function
vim.g.diagnostics_visible = true
function _G.toggle_diagnostics()
  if vim.g.diagnostics_visible then
    vim.g.diagnostics_visible = false
    vim.diagnostic.enable(false)
    print("Diagnostics disabled")
  else
    vim.g.diagnostics_visible = true
    vim.diagnostic.enable()
    print("Diagnostics enabled")
  end
end

-- Function to execute the current file from NERDTree root directory
function _G.execute_file()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand('%:p')

  -- Get NERDTree root directory
  local root_dir = nil
  local success, result = pcall(function()
    return vim.api.nvim_eval("g:NERDTree.ForCurrentTab().getRoot().path.str()")
  end)

  if success then
    root_dir = result
  else
    vim.notify("Could not get NERDTree root directory, using current directory", vim.log.levels.WARN)
    root_dir = vim.fn.getcwd()
  end

  -- Get relative path from root directory
  local relative_path = filename
  if root_dir and filename:sub(1, #root_dir) == root_dir then
    relative_path = filename:sub(#root_dir + 2) -- +2 to account for the trailing slash
  end

  -- Mapping of filetypes to execution commands
  local commands = {
    python = 'python3 "' .. relative_path .. '"',
    lua = 'lua "' .. relative_path .. '"',
    javascript = 'node "' .. relative_path .. '"',
    typescript = 'ts-node "' .. relative_path .. '"',
    sh = 'bash "' .. relative_path .. '"',
    rust = 'rustc "' .. relative_path .. '" -o /tmp/rustexec && /tmp/rustexec',
    go = 'go run "' .. relative_path .. '"',
    ruby = 'ruby "' .. relative_path .. '"',
    php = 'php "' .. relative_path .. '"',
    perl = 'perl "' .. relative_path .. '"',
    java = 'javac "' .. relative_path .. '" && java "' .. vim.fn.expand('%:t:r') .. '"',
    c = 'gcc "' .. relative_path .. '" -o /tmp/cexec && /tmp/cexec',
    cpp = 'g++ "' .. relative_path .. '" -o /tmp/cppexec && /tmp/cppexec',
  }

  -- Get the command for the current filetype
  local command = commands[filetype]

  -- If no specific command is found, try to execute based on file permissions
  if not command then
    if vim.fn.executable(filename) == 1 then
      command = '"./' .. relative_path .. '"'
    else
      vim.notify("Don't know how to execute filetype: " .. filetype, vim.log.levels.ERROR)
      return
    end
  end

  -- Save the current buffer before executing
  vim.cmd('silent! write')

  -- Open a terminal without the auto-close functionality
  vim.cmd('belowright 15split | terminal bash -c "cd \\"' ..
    root_dir .. '\\" && ' .. command .. '; echo -e \\"\\n[Finished with exit code $?. Press q to close.]\\""')

  -- Get the buffer number of the new terminal
  local term_bufnr = vim.api.nvim_get_current_buf()

  -- Set terminal to normal mode after command execution to allow scrolling
  -- Create a unique group name to avoid conflicts
  local augroup_name = "TermExec" .. term_bufnr
  vim.api.nvim_create_augroup(augroup_name, { clear = true })

  -- After job completes, switch to normal mode and set up 'q' to close
  vim.api.nvim_create_autocmd("TermOpen", {
    buffer = term_bufnr,
    group = augroup_name,
    callback = function()
      -- After terminal job completes, switch to normal mode
      vim.api.nvim_create_autocmd("TermClose", {
        buffer = term_bufnr,
        group = augroup_name,
        callback = function()
          vim.cmd("normal! i")  -- Ensure we're in insert mode first
          vim.cmd("stopinsert") -- Then switch to normal mode

          -- Map 'q' key to close the terminal window in this specific buffer
          vim.api.nvim_buf_set_keymap(term_bufnr, 'n', 'q',
            ':bd!<CR>', { noremap = true, silent = true })

          -- Display a helpful message
          vim.api.nvim_echo(
            { { "Terminal finished. You can scroll with normal Vim motions. Press 'q' to close.", "WarningMsg" } }, false,
            {})
        end,
        once = true
      })
    end,
    once = true
  })

  -- Enter insert mode in the terminal
  vim.cmd('startinsert')
end

-- Make functions available globally
M.packer_bootstrap = packer_bootstrap

return M

