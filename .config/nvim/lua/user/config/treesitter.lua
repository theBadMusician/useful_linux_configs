-- ~/.config/nvim/lua/user/config/treesitter.lua
-- Treesitter configuration

-- Safely require the plugin
local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  -- Exit the script quietly if the plugin isn't installed yet
  return
end

-- Treesitter config
treesitter.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "python", "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = false,

  highlight = {
    enable = true,

    -- Disable highlighting for large files to improve performance
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    additional_vim_regex_highlighting = false,
  },
}
