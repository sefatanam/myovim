return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  lazy = false,
  opts = {},
  keys = {
    {
      "<leader>=",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
