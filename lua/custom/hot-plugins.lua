return {
  { "NvChad/NvChad",           branch = "v2.5",             import = "nvchad.plugins" },
  { "nvchad/volt", },
  { "nvchad/minty",            cmd = { "Shades", "Huefy" }, },
  { "nvchad/menu", },
  { "Bekaboo/deadcolumn.nvim", },
  {
    'Bekaboo/dropbar.nvim',
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    }
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "1.2.0",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig",         -- optional
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("lualine").setup({ options = { theme = "moonfly" } })
    end
  },
  { 'akinsho/toggleterm.nvim', version = "*", config = true },
}
