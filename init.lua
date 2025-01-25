vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end


vim.opt.rtp:prepend(lazypath)
local lazy_config = require "configs.lazy"
require "custom.autocmds"
require "custom.options"

-- require("lazy").setup({ { import = "custom.plugins" } }, lazy_config)
-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { "nvchad/volt", },
  { "nvchad/minty",            cmd = { "Shades", "Huefy" }, },
  { "nvchad/menu", },
  { "Bekaboo/deadcolumn.nvim", },
  { import = "plugins" },
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
    opts = {}
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
    opts = {}                          -- your configuration
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  { 'akinsho/toggleterm.nvim', version = "*", config = true },
  { import = "custom.plugins" }
}, lazy_config)

require("cmp").config.formatting = {
  format = require("tailwindcss-colorizer-cmp").formatter
}
-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"


vim.schedule(function()
  require "mappings"
end)
require("telescope").load_extension("ui-select")
require("lualine").setup({ options = { theme = "nord" } })
