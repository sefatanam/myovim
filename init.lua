vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)
vim.opt.scrolloff = 10
vim.opt.relativenumber = true -- Enable relative number
vim.opt.number = true         -- Also show the current line number
vim.opt.expandtab = true      -- Convert tabs to spaces
vim.opt.smartindent = true    -- Enable smart indentation
vim.opt.shiftwidth = 4        -- Number of spaces for each indentation level
vim.opt.tabstop = 4           -- Number of spaces a tab counts for
vim.opt.softtabstop = 4       -- Number of spaces a tab key inserts


vim.opt.list = true
vim.opt.listchars:append("space:.")

vim.diagnostic.config({
  virtual_text = true,     -- Show inline diagnostics
  signs = true,            -- Show signs in the gutter
  underline = true,        -- Underline the diagnostic text
  update_in_insert = true, -- Update diagnostics in insert mode
  severity_sort = true,    -- Sort diagnostics by severity
})



local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { "nvchad/volt",             lazy = true },
  { "nvchad/minty",            cmd = { "Shades", "Huefy" }, },
  { "nvchad/menu",             lazy = false },
  { "Bekaboo/deadcolumn.nvim", lazy = false },
  { import = "plugins" },
  {
    'Bekaboo/dropbar.nvim',
    lazy = false,
    -- optional, but required for fuzzy finder support
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    }
  },
  {
    "utilyre/barbecue.nvim",
    lazy = false,
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
    lazy = false,
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
    lazy = false,
  },
  { 'akinsho/toggleterm.nvim', version = "*", config = true }
}, lazy_config)

require("cmp").config.formatting = {
  format = require("tailwindcss-colorizer-cmp").formatter
}
-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"
require("lualine").setup({ options = { theme = "nord" } })
vim.schedule(function()
  require "mappings"
end)

require("telescope").load_extension("ui-select")
