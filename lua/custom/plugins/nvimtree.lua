return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 50,                         -- Default width for the tree
        preserve_window_proportions = true, -- Keep window proportions when resizing
      },
      auto_reload_on_write = true,          -- Reload tree when files are written
      update_focused_file = {
        enable = true,                      -- Update the focused file
        update_cwd = true,                  -- Update the working directory
      },
      git = {
        enable = true, -- Show git status in the tree
      },
    })

    -- Persist nvim-tree width across sessions
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local width = vim.g.nvim_tree_width
        if width then
          vim.cmd("vertical resize " .. width)
        end
      end
    })

    vim.api.nvim_create_autocmd("WinLeave", {
      pattern = "NvimTree*",
      callback = function()
        vim.g.nvim_tree_width = vim.api.nvim_win_get_width(0)
      end
    })
  end,
}
