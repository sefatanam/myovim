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


-- Background transparent
-- vim.cmd [[
--   highlight Normal guibg=none
--   highlight NonText guibg=none
--   highlight Normal ctermbg=none
--   highlight NonText ctermbg=none
-- ]]

