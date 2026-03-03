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

  " --- Macros and Preprocessor (Pink & Light Blue) ---
  " Directives like #include and #define (Pink)
  hi @keyword.directive guifg=#c586c0
  hi @keyword.directive.define guifg=#c586c0
  " Macro constants and functions 
  hi @constant.macro guifg=#4fc1ff
  hi @function.macro guifg=#dcdcaa

  " --- Functions (Yellow) ---
  hi @function guifg=#dcdcaa
  hi @function.call guifg=#dcdcaa
  hi @function.builtin guifg=#dcdcaa

  " --- Types and Structures (Blue & Teal) ---
  " Built-in types like int, void, char (Blue)
  hi @type.builtin guifg=#569cd6
  " Custom structs, enums, and typedefs (Teal)
  hi @type guifg=#4ec9b0
  hi @type.definition guifg=#4ec9b0

  " --- Keywords and Control Flow (Pink & Blue) ---
  " Control flow like if, else, return, while (Pink)
  hi @keyword.conditional guifg=#c586c0
  hi @keyword.repeat guifg=#c586c0
  hi @keyword.return guifg=#c586c0
  " General keywords (Blue)
  hi @keyword guifg=#569cd6

  " --- Variables and Parameters (Light Blue) ---
  hi @variable guifg=#9cdcfe
  hi @variable.parameter guifg=#9cdcfe

  " --- Literals (Green, Orange, Blue) ---
  " Numbers (Light Green)
  hi @number guifg=#b5cea8
  hi @number.float guifg=#b5cea8
  " Booleans (Blue)
  hi @boolean guifg=#569cd6
  " Strings and Chars (Orange/Rust)
  hi @string guifg=#ce9178
  hi @character guifg=#ce9178

  " --- Punctuation and Operators (Light Gray) ---
  hi @operator guifg=#d4d4d4
  hi @punctuation.delimiter guifg=#d4d4d4
  hi @punctuation.bracket guifg=#d4d4d4

  " --- Comments (Green) ---
  hi @comment guifg=#6a9955 gui=italic
]])
