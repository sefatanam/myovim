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

map({'i', 'n', 'v'}, "<C-s>", "<cmd> wa <cr>", { noremap = true, silent = true, desc = "Save file" })
