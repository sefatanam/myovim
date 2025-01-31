return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  }, {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    local lspconfig = require("lspconfig")

    mason_lspconfig.setup({
      ensure_installed = {
        "html",
        "cssls",
        "svelte",
        "angularls",
        "ts_ls",
        "denols",
        "jsonls",
        "gopls",
        "rust_analyzer",
        "dockerls",
        "cmake",
        "astro",
        "bashls",
        "lua_ls"
      },
    })
    -- Setup LSP servers
    mason_lspconfig.setup_handlers({
      function(server_name) -- Default setup for all servers
        lspconfig[server_name].setup({})
      end,
      ["ts_ls"] = function()
        lspconfig.ts_ls.setup({
          root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
        })
      end,
      ["denols"] = function()
        lspconfig.denols.setup({
          root_dir = function(fname)
            local root = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(fname)
            if root then
              return root
            end
            return nil
          end,
        })
      end,
      ["angularls"] = function()
        -- Load Mason's registry
        local ok, mason_registry = pcall(require, 'mason-registry')
        if not ok then
          vim.notify 'mason-registry could not be loaded'
          return
        end
        -- Get Angular Language Server's install path from Mason
        local angularls_path = mason_registry.get_package('angular-language-server'):get_install_path()
        -- Define the command to start ngserver with correct paths
        local cmd = {
          'ngserver',
          '--stdio',
          '--tsProbeLocations',
          table.concat({
            angularls_path,
            vim.uv.cwd(),
          }, ','),
          '--ngProbeLocations',
          table.concat({
            angularls_path .. '/node_modules/@angular/language-server',
            vim.uv.cwd(),
          }, ','),
        }
        -- LSP configuration for angularls
        local config = {
          cmd = cmd, -- The dynamically built command
          on_new_config = function(new_config, new_root_dir)
            -- Update the command with new configuration if needed
            new_config.cmd = cmd
          end,
          root_dir = lspconfig.util.root_pattern('angular.json', '.git'),                           -- Detect Angular projects
          filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" }, -- File types for Angular
          capabilities = require('nvchad.configs.lspconfig').capabilities,                          -- Capabilities, like autocompletion
          on_attach = require('nvchad.configs.lspconfig').on_attach,                                -- Attach custom LSP behaviors
        }
        lspconfig.angularls.setup(config)
      end,
    })
  end,
}
}
