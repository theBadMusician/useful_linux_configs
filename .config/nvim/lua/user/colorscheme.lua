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

