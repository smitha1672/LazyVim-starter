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

vim.g.autoformat = false -- Disable LazyVim format-on-save

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = "a" -- Enable mouse support
opt.swapfile = false -- Don't use swapfile
opt.completeopt = "menuone,noinsert,noselect" -- Autocomplete options

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true -- Show line number
opt.showmatch = true -- Highlight matching parenthesis
opt.colorcolumn = "0" -- No line length marker
opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split to the bottom
opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.linebreak = true -- Wrap on word boundary
opt.laststatus = 3 -- Set global statusline

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
-- The style (spaces/tabs) is persisted by the <leader>ui toggle in config/keymaps.lua
g.indent_style_path = vim.fn.stdpath("state") .. "/indent_style"

local indent_style = "spaces"
if vim.fn.filereadable(g.indent_style_path) == 1 then
  indent_style = vim.trim(vim.fn.readfile(g.indent_style_path)[1] or indent_style)
end

opt.expandtab = indent_style ~= "tabs" -- Use spaces instead of tabs unless saved otherwise
opt.shiftwidth = 4 -- Shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 250 -- ms to wait for trigger an event

-----------------------------------------------------------
-- Clipboard
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
end

-- Copy/paste to system clipboard (including WSL)
opt.clipboard = "unnamedplus"
