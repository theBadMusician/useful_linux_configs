-- ~/.config/nvim/lua/colorscheme.lua
-- Colorscheme and visual customizations

-- Set background mode
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
