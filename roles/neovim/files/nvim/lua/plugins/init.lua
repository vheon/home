return {
    { "tpope/vim-commentary" },
    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },
    { "tpope/vim-eunuch" },

    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<Leader>gh", ":Gtabedit @<cr>", { silent = true })
        end,
    },

    -- XXX(vheon): try to remap the quit button to `gq` to be consistent with
    -- fugitive and dirfish
    {
        "junegunn/gv.vim",
        config = function()
            vim.keymap.set("n", "<leader>gl", ":GV<cr>")
            vim.keymap.set("n", "<Leader>gr", ":GV -20<cr>")
        end,
    },

    {
        "TimUntersberger/neogit",
        dependencies = {
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
    },

    {
        "rcarriga/nvim-notify",
        init = function()
            vim.notify = function(...)
                vim.notify = require "notify"
                return vim.notify(...)
            end
        end,
    },

    { "justinmk/vim-dirvish" },

    { "tpope/vim-unimpaired" },
    { "tpope/vim-abolish" },
    { "tpope/vim-rsi" },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            -- "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            ---@diagnostic disable: need-check-nil
            local cmp = require "cmp"
            cmp.setup {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
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
    },

    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        config = {
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
        },
    },

    { "tpope/vim-scriptease" },

    { "pboettch/vim-cmake-syntax" },
    { "chikamichi/mediawiki.vim" },
    { "elixir-editors/vim-elixir" },

    {
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
    },

    {
        "wincent/ferret",
        config = function()
            vim.g.FerretMap = 0
            vim.g.FerretAutojump = 0
            vim.keymap.set("n", "<Leader>sw", ":Ack! -w <C-r><C-w><cr>", { silent = true })
        end,
    },

    -- XXX(andrea): I use this mainly in the shell so I should just install it through ansible rather than in here
    {
        "junegunn/fzf",
        build = "./install --xdg --no-update-rc --no-key-bindings --no-completion",
    },

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzy-native.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        keys = {
            { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Helptags" },
            { "<leader>tb", "<cmd>Telescope builtin<cr>", desc = "Telescope builtins" },
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
        end,
    },

    { "bakpakin/fennel.vim" },

    { "pprovost/vim-ps1" },
    { "pearofducks/ansible-vim" },

    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufReadPost",
        build = ":TSUpdate", -- XXX(andrea): we need to :TSInstall maintained on first install
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/playground",
            "RRethy/nvim-treesitter-endwise",
        },
        config = function()
            require("treesitter-context").setup { enable = false }
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "cmake",
                    "css",
                    "diff",
                    "dockerfile",
                    "elixir",
                    "erlang",
                    "fennel",
                    "fish",
                    "git_rebase",
                    "gitattributes",
                    "gitcommit",
                    "go",
                    "gomod",
                    "hcl",
                    "help",
                    "html",
                    "http",
                    "javascript",
                    "json",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "perl",
                    "python",
                    "ruby",
                    "rust",
                    "sql",
                    "teal",
                    "terraform",
                    "vim",
                    "yaml",
                },
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

    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        {
            "neovim/nvim-lspconfig",
            dependencies = {
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
                        null_ls.builtins.formatting.stylua,
                    },
                    on_attach = on_attach,
                }
            end,
        },
    },

    { "khaveesh/vim-fish-syntax" },

    { "kyazdani42/nvim-web-devicons" },

    {
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
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
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
                custom_highlights = function(colors)
                    return {
                        User3 = { bg = colors.mantle, fg = colors.peach, italic = true },
                        User4 = { bg = colors.mantle, fg = colors.teal },
                        User5 = { bg = colors.teal, fg = colors.base, bold = true },
                    }
                end,
            }
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = {
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
            },
            routes = {
                {
                    filter = { event = "msg_show", kind = "", find = "written" },
                    opts = { skip = true },
                },
            },
        },
    },
}
