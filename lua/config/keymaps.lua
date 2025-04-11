-- ~/.config/nvim/lua/config/keymap.lua (or wherever you place custom mappings)

-- Keymaps are automatically loaded on the VeryLazy event.
-- Default LazyVim keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local g = vim.g
local opt = vim.opt
local fn = vim.fn
local api = vim.api

-----------------------------------------------------------
-- Indent Style Setup
-----------------------------------------------------------
local indent_config_path = fn.stdpath("config") .. "/.indent_style"

-- Helper to trim input safely
local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- Default: spaces
local indent_style = "spaces"

-- Read `.indent_style` file if present
if fn.filereadable(indent_config_path) == 1 then
  local lines = fn.readfile(indent_config_path)
  if lines and lines[1] then
    indent_style = trim(lines[1])
  end
end

-- Apply indent preference
local function apply_indent_style(style)
  if style == "tabs" then
    opt.expandtab = false
  else
    opt.expandtab = true
  end
  opt.tabstop = 4
  opt.shiftwidth = 4
end

apply_indent_style(indent_style)

-----------------------------------------------------------
-- Toggle and Persist Indent Style
-----------------------------------------------------------
local function save_indent_style()
  local current = opt.expandtab:get() and "spaces" or "tabs"
  local saved = fn.filereadable(indent_config_path) == 1 and trim(fn.readfile(indent_config_path)[1] or "") or nil
  if current ~= saved then
    fn.writefile({ current }, indent_config_path)
  end
end

function ToggleExpandTab()
  opt.expandtab = not opt.expandtab:get()
  local status = opt.expandtab:get() and "Spaces Enabled" or "Tabs Enabled"
  print("<C-t>: " .. status)
  save_indent_style()
end

function ShowExpandTabStatus()
  local status = opt.expandtab:get() and "Spaces Enabled" or "Tabs Enabled"
  print("<C-t>: " .. status)
end

-- Toggles between Treesitter-based folding and manual folding
function ToggleFoldMode()
  -- If currently using Treesitter folds (`expr`), switch to manual
  if opt.foldmethod:get() == "expr" then
    opt.foldmethod = "manual"
    print("<C-f>: Switched to manual fold mode (zf enabled)")
  else
    -- Otherwise, restore Treesitter folding settings
    opt.foldmethod = "expr"
    opt.foldexpr = "nvim_treesitter#foldexpr()"
    print("<C-f>: Switched to Treesitter fold mode (auto folds)")
  end
end

-----------------------------------------------------------
-- Keymap
-----------------------------------------------------------
api.nvim_set_keymap("n", "<C-t>", ":lua ToggleExpandTab()<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<C-f>", ":lua ToggleFoldMode()<CR>", { noremap = true, silent = true })

-----------------------------------------------------------
-- Auto Status Print on Startup
-----------------------------------------------------------
vim.defer_fn(ShowExpandTabStatus, 1000)
