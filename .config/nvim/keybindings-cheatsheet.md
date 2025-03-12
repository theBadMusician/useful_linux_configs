# Neovim Key Bindings Cheat Sheet

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
| `<leader>kc` | Normal | Open this keybindings cheatsheet |