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
          actions = {
            copy_file_path = function(_, item)
              if not item then
                return
              end
              local path = vim.fn.fnamemodify(item.file, ":p")
              vim.fn.setreg('"', path)
              vim.fn.setreg("+", path)
              Snacks.notify.info("Copied: " .. path)
            end,
          },
          win = {
            list = {
              keys = {
                ["Y"] = "copy_file_path",
              },
            },
          },
        },
      },
    },
  },
}
