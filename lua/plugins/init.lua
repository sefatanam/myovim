return {
  "nvim-lua/plenary.nvim",
  { "joeveiga/ng.nvim" },
  {
    "nvchad/base46",
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  {
    "nvchad/ui",
    config = function()
      require "nvchad"
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {

    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "InsertEnter", "BufEnter", "BufRead" },
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          auto_accept = false,
          auto_trigger = true,
          debounce = 65,
          keymap = {
            accept = "<Tab>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 16.x
        server_opts_overrides = {},
      })
    end,
  },
  {
    "m4xshen/autoclose.nvim",
    event = "BufEnter",
    config = function()
      require("autoclose").setup()
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    lazy = false,
    opts = {},
    keys = {
      {
        "<leader>=",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
    opts = {
      -- Defaults
      enable_close = true,          -- Auto close tags
      enable_rename = true,         -- Auto rename pairs of tags
      enable_close_on_slash = false -- Auto close on trailing </
    },

  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
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
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = false,
    -- This is your opts table
    require("telescope").setup {
      pickers = {
        quickfix = {
          theme = "dropdown", -- Optional: Set a theme for the quickfix picker
        },
      },
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          ".git",
          ".cache",
          ".github",
          ".vscode",
          ".idea",
          ".gitignore",
          ".gitattributes",
          ".gitmodules",
          ".DS_Store",
          ".editorconfig",
          ".eslintignore",
          ".eslintrc",
          ".prettierignore",
          ".prettierrc",
          ".stylelintrc",
          ".stylelintignore",
          ".huskyrc",
          ".lintstagedrc",
          ".browserslistrc",
          ".babelrc",
        },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden',
          '--glob', '!.git/',
          '--glob', '!node_modules/'
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {}
        }
      }
    }
  },
  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/nvim-session' },
      -- log_level = 'debug',
    },

    config = function()
      require('auto-session').setup {
      }
    end
  },
  -- Add nvim-tree configuration
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
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
      -- vim.api.nvim_create_autocmd("VimEnter", {
      --   callback = function()
      --     local width = vim.g.nvim_tree_width
      --     if width then
      --       vim.cmd("vertical resize " .. width)
      --     end
      --   end
      -- })
      --
      -- vim.api.nvim_create_autocmd("WinLeave", {
      --   pattern = "NvimTree*",
      --   callback = function()
      --     vim.g.nvim_tree_width = vim.api.nvim_win_get_width(0)
      --   end
      -- })
    end,
  },
  {
    "f-person/git-blame.nvim",
    -- load the plugin at startup
    event = "VeryLazy",
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin wil only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
      -- your configuration comes here
      -- for example
      enabled = true, -- if you want to enable the plugin
      message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
      date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
    },
  }
}
