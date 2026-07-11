-- ~/.config/nvim/lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
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
