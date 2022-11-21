vim.cmd [[packadd packer.nvim]]

return require("packer").startup {
  function(use)
    local function prefer_local_use(package)
      if type(package) == "string" then
        package = { package }
      end
      local _, path = next(package)
      path = "~/code/" .. path:match "[^/]*$"
      if vim.loop.fs_stat(vim.fn.expand(path)) ~= nil then
        package[1] = path
      elseif package.upstream ~= nil then
        package[1] = package.upstream
        package.upstream = nil
      end
      use(package)
    end

    use { "wbthomason/packer.nvim", opt = true }

    use "tpope/vim-commentary"
    use "tpope/vim-surround"
    use "tpope/vim-repeat"
    use "tpope/vim-eunuch"

    use {
      "tpope/vim-fugitive",
      config = function()
        vim.keymap.set("n", "<Leader>gh", ":Gtabedit @<cr>", { silent = true })
      end,
    }

    -- XXX(vheon): try to remap the quit button to `gq` to be consistent with
    -- fugitive and dirfish
    use {
      "junegunn/gv.vim",
      config = function()
        vim.keymap.set("n", "<leader>gl", ":GV<cr>")
        vim.keymap.set("n", "<Leader>gr", ":GV -20<cr>")
      end,
    }

    prefer_local_use {
      "neogit",
      upstream = "TimUntersberger/neogit",
      requires = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
      },
      config = function()
        local neogit = require "neogit"
        neogit.setup {
          disable_builtin_notifications = true,
          disable_commit_confirmation = true,
          integrations = { diffview = true },
          mappings = {
            status = {
              gq = "Close",
              b = "",
              B = "BranchPopup",
            },
          },
          signs = {
            section = { "", "" },
            item = { "", "" },
            hunk = { "", "▾" },
          },
        }
        vim.keymap.set("n", "<Leader>gs", function()
          neogit.open()
        end)
      end,
    }

    use {
      "rcarriga/nvim-notify",
      config = function()
        vim.notify = require "notify"
      end,
    }

    use "justinmk/vim-dirvish"

    use "tpope/vim-unimpaired"
    use "tpope/vim-abolish"
    use "tpope/vim-rsi"

    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        -- "hrsh7th/cmp-cmdline",
      },
      config = function()
        local cmp = require "cmp"
        if cmp == nil then
          return
        end
        cmp.setup {
          window = {
            -- completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
          },
          sources = {
            { name = "nvim_lsp" },
            -- { name = 'luasnip' }, -- For luasnip users.
            {
              name = "buffer",
              option = {
                get_bufnrs = function()
                  return vim.api.nvim_list_bufs()
                end,
              },
            },
          },
          mapping = cmp.mapping.preset.insert {
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
          },
          experimental = {
            ghost_text = true,
          },
        }
      end,
    }

    use {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup {
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            vim.keymap.set("n", "]c", function()
              if vim.wo.diff then
                return "]c"
              end
              vim.schedule(function()
                gs.next_hunk()
              end)
              return "<Ignore>"
            end, { buffer = bufnr, expr = true })

            vim.keymap.set("n", "[c", function()
              if vim.wo.diff then
                return "[c"
              end
              vim.schedule(function()
                gs.prev_hunk()
              end)
              return "<Ignore>"
            end, { buffer = bufnr, expr = true })

            vim.keymap.set("n", "<Leader>gp", gs.preview_hunk, { buffer = bufnr })
          end,
        }
      end,
    }

    use "tpope/vim-scriptease"

    use "pboettch/vim-cmake-syntax"
    use "chikamichi/mediawiki.vim"
    use "elixir-editors/vim-elixir"

    use {
      "kevinhwang91/nvim-bqf",
      config = function()
        require("bqf").setup {
          preview = {
            auto_preview = false,
          },
        }
        vim.keymap.set("n", "<Leader>q", function()
          local nr = #vim.api.nvim_list_wins()
          vim.cmd "cwindow"
          if nr == #vim.api.nvim_list_wins() then
            vim.cmd "cclose"
          end
        end)
      end,
    }

    use {
      "wincent/ferret",
      config = function()
        vim.g.FerretMap = 0
        vim.g.FerretAutojump = 0
        vim.keymap.set("n", "<Leader>sw", ":Ack! -w <C-r><C-w><cr>", { silent = true })
      end,
    }

    -- XXX(andrea): I use this mainly in the shell so I should just install it through ansible rather than in here
    use { "junegunn/fzf", run = "./install --xdg --no-update-rc --no-key-bindings --no-completion" }

    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzy-native.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
      },
      config = function()
        local telescope = require "telescope"
        local actions = require "telescope.actions"
        telescope.setup {
          defaults = {
            -- color_devicons = false,
            mappings = {
              i = {
                ["<c-c>"] = function()
                  vim.cmd "stopinsert"
                end,
                ["<esc>"] = actions.close,
              },
            },
          },
          pickers = {
            git_files = {
              show_untracked = true,
            },
          },
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown {},
            },
          },
        }
        telescope.load_extension "fzy_native"
        telescope.load_extension "ui-select"
        telescope.load_extension "notify"

        local builtin = require "telescope.builtin"
        vim.keymap.set("n", "<Leader>fg", builtin.git_files, {})
        vim.keymap.set("n", "<Leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<Leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<Leader>fh", builtin.help_tags, {})
        vim.keymap.set("n", "<Leader>tb", builtin.builtin, {})
      end,
    }

    use "bakpakin/fennel.vim"

    use "pprovost/vim-ps1"
    use "pearofducks/ansible-vim"

    use {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
      "RRethy/nvim-treesitter-endwise",
      {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate", -- XXX(andrea): we need to :TSInstall maintained on first install
        config = function()
          require("treesitter-context").setup { enable = false }
          require("nvim-treesitter.configs").setup {
            highlight = {
              enable = true,
            },
            textobjects = {
              move = {
                enable = true,
                goto_next_start = {
                  ["]m"] = "@function.outer",
                  ["]]"] = "@class.outer",
                },
                goto_next_end = {
                  ["]M"] = "@function.outer",
                  ["]["] = "@class.outer",
                },
                goto_previous_start = {
                  ["[m"] = "@function.outer",
                  ["[["] = "@class.outer",
                },
                goto_previous_end = {
                  ["[M"] = "@function.outer",
                  ["[]"] = "@class.outer",
                },
              },
              select = {
                enable = true,
                keymaps = {
                  ["i,"] = "@parameter.inner",
                  ["a,"] = "@parameter.outer",
                },
              },
              swap = {
                enable = true,
                swap_next = {
                  [">,"] = "@parameter.inner",
                },
                swap_previous = {
                  ["<,"] = "@parameter.inner",
                },
              },
            },
            endwise = {
              enable = true,
            },
          }
        end,
      },
    }

    use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      {
        "neovim/nvim-lspconfig",
        requires = {
          "nvim-lua/plenary.nvim",
        },
        config = function()
          require("lspconfig.ui.windows").default_options.border = "rounded"
          require("mason").setup {
            max_concurrent_installers = 10,
            ui = {
              border = "rounded",
              icons = {
                package_installed = "",
                package_pending = "",
                package_uninstalled = "",
              },
            },
            keymaps = {
              toggle_package_expand = "<Tab>",
            },
          }
          require("mason-lspconfig").setup { automatic_installation = true }

          vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
          -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

          local on_attach = function(client, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

            -- Mappings
            local opts = { buffer = bufnr }
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            if client.supports_method "textDocument/formatting" then
              vim.keymap.set("n", "gq", function()
                vim.lsp.buf.format(opts)
              end, opts)
            end
            if client.supports_method "textDocument/rangeFormatting" then
              vim.keymap.set("v", "gq", "<esc><cmd>lua vim.lsp.buf.range_formatting()<cr>", opts)
            end
          end

          local servers = { "gopls", "ansiblels", "yamlls" }
          for _, lsp in pairs(servers) do
            require("lspconfig")[lsp].setup { on_attach = on_attach }
          end

          require("lspconfig").sumneko_lua.setup {
            on_attach = on_attach,
            settings = {
              Lua = {
                runtime = {
                  -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                  version = "LuaJIT",
                },
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { "vim" },
                },
                workspace = {
                  -- Make the server aware of Neovim runtime files
                  library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                  enable = false,
                },
              },
            },
          }
          local null_ls = require "null-ls"
          null_ls.setup {
            sources = {
              -- require('clang-format-range')
              null_ls.builtins.formatting.clang_format,
              null_ls.builtins.formatting.stylua,
            },
            on_attach = on_attach,
          }
        end,
      },
    }

    use "khaveesh/vim-fish-syntax"

    use "kyazdani42/nvim-web-devicons"

    use {
      "akinsho/nvim-toggleterm.lua",
      branch = "main",
      config = function()
        require("toggleterm").setup {
          direction = "float",
          open_mapping = [[<C-\><C-\>]],
          insert_mappings = false,
          float_opts = {
            border = "rounded",
          },
        }
      end,
    }

    use {
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
        require("catppuccin").setup {
          flavour = "mocha", -- mocha, macchiato, frappe, latte
          term_colors = true,
          integrations = {
            mason = true,
            neogit = true,
            notify = true,
            noice = true,
          },
        }
      end,
    }

    use {
      "folke/noice.nvim",
      event = "VimEnter",
      config = function()
        require("noice").setup {
          routes = {
            {
              filter = { event = "msg_show", kind = "", find = "written" },
              opts = { skip = true },
            },
          },
        }
        require("telescope").load_extension "noice"
      end,
      requires = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
    }

    -- plugin to bundle all nvim settings for work
    -- local_use 'bigfixdev.nvim'
  end,
  config = {
    disable_commands = true,
    display = {
      non_interactive = #vim.api.nvim_list_uis() == 0,
      open_cmd = "tabnew",
      keybindings = {
        quit = "gq",
      },
    },
  },
}
