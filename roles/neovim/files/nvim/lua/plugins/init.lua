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
        "pwntester/octo.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = true
    },

    -- XXX(andrea): this could be lazy loaded
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        opts = {
            enhanced_diff_hl = true,
            view = {
                merge_tool = {
                    layout = "diff1_plain",
                },
            },
            file_panel = {
                win_config = {
                    width = 45,
                },
            },
            hooks = {
                diff_buf_read = function()
                    vim.opt_local.wrap = false
                end,
            },
        },
    },

    {
        "TimUntersberger/neogit",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Neogit",
        keys = {
            { "<Leader>gs", function() require("neogit").open() end, desc = "open status buffer" },
        },
        opts = {
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
        },
    },

    {
        "rcarriga/nvim-notify",
        lazy = true,
        opts = {
            stages = "static",
        },
        init = function()
            ---@diagnostic disable: duplicate-set-field
            vim.notify = function(...)
                vim.notify = require "notify"
                return vim.notify(...)
            end
        end,
    },

    {
        "stevearc/oil.nvim",
        opts = {
            skip_confirm_for_simple_edits = true,
            keymaps = {
                ["gq"] = "actions.close",
            },
        },
        config = function(_, opts)
            local oil = require "oil"
            oil.setup(opts)
            vim.keymap.set("n", "-", oil.open, { desc = "Open parent directory" })
        end,
    },

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
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-cmdline",
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
                    documentation = cmp.config.window.bordered(),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
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
            cmp.setup.cmdline(":", {
                sources = {
                    { name = "path" },
                    { name = "cmdline" },
                },
                mapping = cmp.mapping.preset.cmdline(),
            })
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            _signs_staged_enable = true,
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
        opts = {
            preview = {
                auto_preview = false,
            },
        },
        config = function(_, opts)
            require("bqf").setup(opts)
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
        {
            "williamboman/mason.nvim",
            cmd = "Mason",
            opts = {
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
            },
        },
        "jose-elias-alvarez/null-ls.nvim",
        {
            "williamboman/mason-lspconfig.nvim",
            opts = { automatic_installation = true },
            event = { "BufReadPre", "BufNewFile" },
            dependencies = {
                "mason.nvim",
                {
                    "neovim/nvim-lspconfig",
                    dependencies = {
                        "nvim-lua/plenary.nvim",
                    },
                    config = function()
                        require("lspconfig.ui.windows").default_options.border = "rounded"

                        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
                        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
                        vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
                        -- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

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
                            vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
                            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                            vim.keymap.set({ "i", "n", "s" }, "<c-u>", function()
                                if not require("noice.lsp").scroll(-4) then
                                    return "<c-u>"
                                end
                                return ""
                            end, { expr = true, buffer = bufnr })
                            vim.keymap.set({ "i", "n", "s" }, "<c-d>", function()
                                if not require("noice.lsp").scroll(4) then
                                    return "<c-d>"
                                end
                            end, { expr = true, buffer = bufnr })
                            if client.supports_method "textDocument/formatting" then
                                vim.keymap.set("n", "gq", function()
                                    vim.lsp.buf.format(opts)
                                end, opts)
                            end
                            if client.supports_method "textDocument/rangeFormatting" then
                                vim.keymap.set("v", "gq", function()
                                    vim.lsp.buf.format(opts)
                                end, opts)
                            end
                        end

                        local servers = { "gopls", "ansiblels", "yamlls" }
                        for _, lsp in pairs(servers) do
                            require("lspconfig")[lsp].setup { on_attach = on_attach }
                        end

                        require("lspconfig").lua_ls.setup {
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
        },
    },

    {
        "mfussenegger/nvim-dap",
        config = function()
            vim.fn.sign_define {
                {
                    name = "DapBreakpoint",
                    text = "", --  'ﴫ'
                    texthl = "DapBreakpoint",
                    linehl = "",
                    numhl = "",
                },
                {
                    name = "DapBreakpointCondition",
                    text = "",
                    texthl = "DapBreakpointCondition",
                    linehl = "",
                    numhl = "",
                },
                {
                    name = "DapBreakpointRejected",
                    text = "ﰸ",
                    texthl = "DiagnosticError",
                    linehl = "",
                    numhl = "",
                },
                {
                    name = "DapLogPoint",
                    text = "",
                    texthl = "DapLogPoint",
                    linehl = "",
                    numhl = "",
                },
                {
                    name = "DapStopped",
                    text = "",
                    texthl = "DapStopped",
                    linehl = "",
                    numhl = "",
                },
            }
        end,
    },
    {
        "leoluz/nvim-dap-go",
        dependencies = { "mfussenegger/nvim-dap" },
        config = true,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = true,
    },
    {
        "anuvyklack/hydra.nvim",
        config = function()
            local Hydra = require "hydra"

            -- XXX(andrea): this is wrong! either fix it or just use the generated one
            local hint = [[
 _n_: step over   _s_: Continue/Start   _b_: Breakpoint     _K_: Eval
 _i_: step into   _U_: Toggle UI        ^ ^                 ^ ^
 _o_: step out    _X_: Terminate        ^ ^
 _c_: to cursor
 ^
 ^ ^              _q_: exit
]]

            Hydra {
                -- hint = hint,
                config = {
                    color = "pink",
                    invoke_on_body = true,
                    hint = {
                        type = "window",
                        position = "bottom",
                        border = "rounded",
                    },
                },
                name = "dap",
                mode = { "n", "x" },
                body = "<leader>dh",
                heads = {
                    { "n", function() require("dap").step_over() end, { desc = "step over" } },
                    { "i", function() require("dap").step_into() end, { desc = "step into" } },
                    { "o", function() require("dap").step_out() end, { desc = "step out" } },
                    { "c", function() require("dap").continue() end, { desc = "Continue/Start" } },
                    { "C", function() require("dap").run_to_cursor() end, { desc = "to cursor" } },
                    { "X", function() require("dap").terminate() end, { desc = "terminate" } },
                    { "U", function() require("dapui").toggle() end, { desc = "Toggle UI" } },
                    { "b", function() require("dap").toggle_breakpoint() end, { desc = "Breakpoint" } },
                    { "L", function()
                        vim.ui.input({ prompt = "Log point message: " }, function(input)
                            require("dap").set_breakpoint(nil, nil, input)
                        end)
                    end, { desc = "Add Log Point" } },
                    { "K", function() require("dap.ui.widgets").hover() end, { desc = "Eval" } },
                    { "q", nil, { exit = true, nowait = true } },
                },
            }
        end,
    },

    { "AndrewRadev/linediff.vim", cmd = "Linediff" },

    { "khaveesh/vim-fish-syntax" },

    {
        "akinsho/nvim-toggleterm.lua",
        branch = "main",
        opts = {
            direction = "float",
            open_mapping = [[<C-\><C-\>]],
            insert_mappings = false,
            float_opts = {
                border = "rounded",
            },
        },
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            flavour = "mocha", -- mocha, macchiato, frappe, latte
            term_colors = true,
            integrations = {
                mason = true,
                neogit = true,
                notify = true,
                noice = true,
                dap = true,
                overseer = true,
            },
            custom_highlights = function(colors)
                return {
                    User1 = { bg = colors.mantle, fg = colors.surface1, bold = true },
                    User2 = { bg = colors.base, fg = colors.green, bold = true },
                    User3 = { bg = colors.mantle, fg = colors.peach, italic = true },
                    User4 = { bg = colors.mantle, fg = colors.teal },
                    User5 = { bg = colors.teal, fg = colors.base, bold = true },

                    HydraRed = { fg = colors.red },
                    HydraBlue = { fg = colors.blue },
                    HydraAmaranth = { fg = colors.maroon },
                    HydraTeal = { fg = colors.teal },
                    HydraPink = { fg = colors.pink },

                    HydraStatusRed = { fg = colors.base, bg = colors.red, bold = true },
                    HydraStatusRedInv = { bg = colors.base, fg = colors.red, bold = true },
                    HydraStatusBlue = { fg = colors.base, bg = colors.blue, bold = true },
                    HydraStatusBlueInv = { bg = colors.base, fg = colors.blue, bold = true },
                    HydraStatusAmaranth = { fg = colors.base, bg = colors.maroon, bold = true },
                    HydraStatusAmaranthInv = { bg = colors.base, fg = colors.maroon, bold = true },
                    HydraStatusTeal = { fg = colors.base, bg = colors.teal, bold = true },
                    HydraStatusTealInv = { bg = colors.base, fg = colors.teal, bold = true },
                    HydraStatusPink = { fg = colors.base, bg = colors.pink, bold = true },
                    HydraStatusPinkInv = { bg = colors.base, fg = colors.pink, bold = true },
                }
            end,
        },
    },

    {
        "stevearc/overseer.nvim",
        config = function()
            local overseer = require "overseer"
            overseer.setup {
                log = {
                    {
                        type = "echo",
                        level = vim.log.levels.WARN,
                    },
                    {
                        type = "file",
                        filename = "overseer.log",
                        level = vim.log.levels.TRACE,
                    },
                },
                -- strategy = {
                --     "toggleterm",
                --     use_shell = true,
                --     direction = "float",
                --     auto_scroll = true,
                --     close_on_exit = true,
                -- },
            }
            vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle<cr>")
            vim.api.nvim_create_user_command("OverseerRestartLast", function()
                local tasks = overseer.list_tasks { recent_first = true }
                if vim.tbl_isempty(tasks) then
                    vim.notify("No tasks found", vim.log.levels.WARN)
                else
                    overseer.run_action(tasks[1], "restart")
                end
            end, {})
            vim.api.nvim_create_user_command("Grep", function(params)
                local args = vim.fn.expandcmd(params.args)
                -- Insert args at the '$*' in the grepprg
                local cmd, num_subs = vim.o.grepprg:gsub("%$%*", args)
                if num_subs == 0 then
                    cmd = cmd .. " " .. args
                end
                local task = overseer.new_task {
                    cmd = cmd,
                    name = "grep " .. args,
                    components = {
                        {
                            "on_output_quickfix",
                            errorformat = vim.o.grepformat,
                            open = not params.bang,
                            open_height = 8,
                            items_only = true,
                        },
                        -- We don't care to keep this around as long as most tasks
                        { "on_complete_dispose", timeout = 30 },
                        "default",
                    },
                }
                task:start()
            end, { nargs = "*", bang = true })
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                lsp_doc_border = true,
            },
            routes = {
                {
                    filter = { event = "msg_show", kind = "", find = "written" },
                    opts = { skip = true },
                },
            },
        },
    },

    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = true,
    },
}
