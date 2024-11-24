require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Exit terminal mode" })

map('n', '<C-p>', ":Telescope find_files<CR>", { noremap = true, silent = false, desc = "Find Files" })

map({ 'i', 'n', 'v' }, '<C-f>', function()
  vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true, desc = "Format file" })
-- Keyboard users
map("n", "<C-t>", function()
  require("menu").open("default")
end, {})

-- mouse users + nvimtree users!
map("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>"):wa
map({ 'i', 'n', 'v' }, '<C-f>', function()
  vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true, desc = "Format file" })

map({ 'i', 'n', 'v' }, "<C-s>", "<cmd> wa <cr>", { noremap = true, silent = true, desc = "Save file" })
-- https://github.com/joeveiga/ng.nvim?tab=readme-ov-file
local opts = { noremap = true, silent = true }
-- local ng = require("ng");
-- vim.keymap.set("n", "<leader>at", ng.goto_template_for_component, opts)
-- vim.keymap.set("n", "<leader>ac", ng.goto_component_with_template_file, opts)
-- vim.keymap.set("n", "<leader>aT", ng.get_template_tcb, opts)

vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "I", vim.lsp.buf.implementation, opts)


vim.api.nvim_set_keymap('n', '<leader>lg', ':lua LazygitToggle()<CR>', { noremap = true, silent = true })

function LazygitToggle()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
      border = "curved", -- or "single", "double", etc.
    },
    on_open = function(term)
      vim.cmd("startinsert!")
    end,
    on_close = function(term)
      vim.cmd("startinsert!")
    end,
  })
  lazygit:toggle()
end
