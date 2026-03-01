-- Custom highlight for a darker, subtle indentation line
vim.api.nvim_set_hl(0, "SubtleIndent", { fg = "#222222" })

require("ibl").setup({
  indent = {
    -- The thinnest vertical character
    char = "▏",
    -- Apply the custom dark gray color
    highlight = "SubtleIndent",
  },
  -- Disable the brighter current-block highlighting
  scope = {
    enabled = false,
  },
})

