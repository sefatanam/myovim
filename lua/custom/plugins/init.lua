local M = {}


-- Get all Lua files inside the custom/plugins folder
local plugin_files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/custom/plugins/", "*.lua", false, true)

for _, file in ipairs(plugin_files) do
  local plugin_name = file:match(".*/(.*)%.lua$")
  if plugin_name ~= "init" then -- Exclude init.lua itself
    local success, plugin = pcall(require, "custom.plugins." .. plugin_name)
    if success then
      table.insert(M, plugin)
    else
      vim.notify("Error loading plugin: " .. plugin_name, vim.log.levels.ERROR)
    end
  end
end

return M
