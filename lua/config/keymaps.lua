-- Keymaps are automatically loaded on the VeryLazy event.
-- Default LazyVim keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local opt = vim.opt

-- Persist the indent style (see config/options.lua)
local function save_indent_style()
  vim.fn.writefile({ opt.expandtab:get() and "spaces" or "tabs" }, vim.g.indent_style_path)
end

vim.keymap.set("n", "<leader>ui", function()
  opt.expandtab = not opt.expandtab:get()
  save_indent_style()
  vim.notify(opt.expandtab:get() and "Spaces enabled" or "Tabs enabled")
end, { desc = "Toggle spaces/tabs" })

-- Toggles between Treesitter-based folding and manual folding
vim.keymap.set("n", "<leader>uF", function()
  if opt.foldmethod:get() == "expr" then
    opt.foldmethod = "manual"
    vim.notify("Manual fold mode (zf enabled)")
  else
    opt.foldmethod = "expr"
    opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.notify("Treesitter fold mode (auto folds)")
  end
end, { desc = "Toggle fold mode" })
