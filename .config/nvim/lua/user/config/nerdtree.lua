-- ~/.config/nvim/lua/config/nerdtree.lua
-- NERDTree configuration

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
      vim.cmd("wincmd p") -- Move cursor to the previous (last accessed) window
    end
  end
})

-- Show hidden files by default
vim.g.NERDTreeShowHidden = 1

-- Ignore certain files and directories
vim.g.NERDTreeIgnore = {
  "\\.git$",
  "node_modules$",
  "\\.DS_Store$",
  "__pycache__$",
  "\\.venv$",
  "miniconda3$",
  "\\.git$",
  "\\.cache$",
  "\\.idea$",
  "\\.vscode$"
}

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
