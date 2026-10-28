-- ~/.config/nvim/lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>sf",
      function()
        Snacks.picker.grep({
          glob = { "*.c", "*.h", "*.cpp", "*.hpp", "*.config", "CMakeLists.txt" },
        })
      end,
      desc = "Grep in C/C++ headers and source",
    },
  },
  opts = {
    picker = {
      hidden = false,
      sources = {
        explorer = {
          hidden = false,
          ignored = true,
        },
      },
    },
  },
}
