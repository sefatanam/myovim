local vim = vim -- Ensure `vim` is recognized
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
require "custom.options"

-- load plugins
require("lazy").setup({
  { import = "plugins" },
  { import = "custom.hot-plugins" },
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
