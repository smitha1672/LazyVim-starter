-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options hereby

-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g
local opt = vim.opt

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = "a" -- Enable mouse support
opt.clipboard = "unnamedplus" -- Copy/paste to system clipboard
opt.swapfile = false -- Don't use swapfile
opt.completeopt = "menuone,noinsert,noselect" -- Autocomplete options

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true -- Show line number
opt.showmatch = true -- Highlight matching parenthesis
opt.colorcolumn = "0" -- Line lenght marker at 80 columns
opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split to the bottom
opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.linebreak = true -- Wrap on word boundary
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.laststatus = 3 -- Set global statusline

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = false -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = false -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 250 -- ms to wait for trigger an event

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Function to handle pasting correctly
local function my_paste()
  local content = vim.fn.getreg('"')
  return vim.split(content, "\n"), vim.fn.getregtype('"')
end

-- Check if running in SSH (remote)
if vim.env.SSH_TTY then
  -- Use OSC52 for remote clipboard handling
  g.clipboard = {
    name = "osc52",
    copy = {
      ["+"] = function(lines, _)
        require("osc52").copy(table.concat(lines, "\n"))
      end,
      ["*"] = function(lines, _)
        require("osc52").copy(table.concat(lines, "\n"))
      end,
    },
    paste = {
      ["+"] = my_paste,
      ["*"] = my_paste,
    },
  }
else
  -- Use system clipboard (including WSL)
  opt.clipboard = "unnamedplus"
end
