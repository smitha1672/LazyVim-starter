return {
  "tamton-aquib/snacks.nvim",
  opts = {},
  config = function()
    require("snacks").setup()

    vim.keymap.set("n", "<leader>sf", function()
      require("snacks").grep({
        args = {
          "--glob", "*.c",
          "--glob", "*.h",
          "--glob", "*.cpp",
          "--glob", "*.hpp",
          "--glob", "*.config",
          "--glob", "CMakeLists.txt",
        },
      })
    end, { desc = "Snacks grep in C/C++ headers and source" })
  end,
}

