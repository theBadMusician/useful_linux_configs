-- Safely require the plugin so Neovim doesn't crash if it's not installed yet
local status_ok, treesitter_context = pcall(require, "treesitter-context")
if not status_ok then
  return
end

treesitter_context.setup({
  enable = true,
  max_lines = 3,            -- Limits how much screen space the context takes up
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = 'outer',
  mode = 'cursor',
  zindex = 20,
})

