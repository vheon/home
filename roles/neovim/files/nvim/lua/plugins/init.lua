return {
    { "nvim-tree/nvim-web-devicons", lazy = true },
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
        cmd = "Octo",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            picker = "fzf-lua",
        },
        config = true,
    },

    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
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
        "NeogitOrg/neogit",
        dependencies = { "nvim-lua/plenary.nvim" },
        branch = "nightly",
        cmd = "Neogit",
        keys = {
            {
                "<Leader>gs",
                function()
                    require("neogit").open {}
                end,
                desc = "open status buffer",
            },
        },
        opts = {
            disable_builtin_notifications = true,
            disable_commit_confirmation = true,
            mappings = {
                status = {
                    q = false,
                    gq = "Close",
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
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.notify = function(...)
                vim.notify = require "notify"
                return vim.notify(...)
            end
        end,
    },

    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

    {
        "stevearc/oil.nvim",
        keys = "-",
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
        "ibhagwan/fzf-lua",
        cmd = "FzfLua",
        keys = {
            { "<leader>fg", "<cmd>FzfLua git_files<cr>",  desc = "Find Git Files" },
            { "<leader>ff", "<cmd>FzfLua files<cr>",      desc = "Find Files" },
            { "<leader>fb", "<cmd>FzfLua buffers<cr>",    desc = "Buffers" },
            { "<leader>fh", "<cmd>FzfLua help_tags<cr>",  desc = "Find Helptags" },
        },
        opts = {
            "telescope",
            fzf_opts = { ['--info'] = 'default' },
            git = {
                files = {
                    fzf_opts = { ['--scheme'] = 'path' },
                    cmd = "git ls-files --exclude-standard --cached --others"
                }
            }
        },
    },

    { "bakpakin/fennel.vim" },

    { "pprovost/vim-ps1" },
    { "pearofducks/ansible-vim" },

    {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        opts = { enable = false },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufReadPost",
        build = ":TSUpdate", -- XXX(andrea): we need to :TSInstall maintained on first install
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "RRethy/nvim-treesitter-endwise",
        },
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup {
                auto_install = false,
                sync_install = false,
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
                    "regex",
                    "ruby",
                    "rust",
                    "sql",
                    "teal",
                    "terraform",
                    "vim",
                    "vimdoc",
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
        "mfussenegger/nvim-dap",
        lazy = true,
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
        lazy = true,
        dependencies = { "mfussenegger/nvim-dap" },
        opts = {
            dap_configurations = {
                {
                    type = "go",
                    name = "Debug Main (Arguments)",
                    request = "launch",
                    mode = "exec",
                    program = "__debug_bin",
                    args = function()
                        local co = coroutine.running()
                        if co then
                            return coroutine.create(function()
                                local args = {}
                                vim.ui.input({ prompt = "Args: " }, function(input)
                                    args = vim.split(input or "", " ")
                                end)
                                coroutine.resume(co, args)
                            end)
                        else
                            local args = {}
                            vim.ui.input({ prompt = "Args: " }, function(input)
                                args = vim.split(input or "", " ")
                            end)
                            return args
                        end
                    end,
                },
            },
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        dependencies = { "mfussenegger/nvim-dap" },
        config = true,
    },
    {
        "nvimtools/hydra.nvim",
        keys = "<leader>dh",
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
                    {
                        "n",
                        function()
                            require("dap").step_over()
                        end,
                        { desc = "step over" },
                    },
                    {
                        "i",
                        function()
                            require("dap").step_into()
                        end,
                        { desc = "step into" },
                    },
                    {
                        "o",
                        function()
                            require("dap").step_out()
                        end,
                        { desc = "step out" },
                    },
                    {
                        "c",
                        function()
                            require("dap").continue()
                        end,
                        { desc = "Continue/Start" },
                    },
                    {
                        "C",
                        function()
                            require("dap").run_to_cursor()
                        end,
                        { desc = "to cursor" },
                    },
                    {
                        "X",
                        function()
                            require("dap").terminate()
                        end,
                        { desc = "terminate" },
                    },
                    {
                        "U",
                        function()
                            require("dapui").toggle()
                        end,
                        { desc = "Toggle UI" },
                    },
                    {
                        "b",
                        function()
                            require("dap").toggle_breakpoint()
                        end,
                        { desc = "Breakpoint" },
                    },
                    {
                        "L",
                        function()
                            vim.ui.input({ prompt = "Log point message: " }, function(input)
                                require("dap").set_breakpoint(nil, nil, input)
                            end)
                        end,
                        { desc = "Add Log Point" },
                    },
                    {
                        "K",
                        function()
                            require("dap.ui.widgets").hover()
                        end,
                        { desc = "Eval" },
                    },
                    { "q", nil, { exit = true, nowait = true } },
                },
            }
        end,
    },

    { "AndrewRadev/linediff.vim", cmd = "Linediff" },

    { "khaveesh/vim-fish-syntax" },

    { "nyoom-engineering/oxocarbon.nvim" },

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
                component_aliases = {
                    default = {
                        { "display_duration", detail_level = 2 },
                        "on_output_summarize",
                        "on_exit_set_status",
                        "on_complete_notify",
                    },
                },
                task_list = {
                    bindings = {
                        ["r"] = "<CMD>OverseerQuickAction restart<CR>",
                    },
                },
            }
            vim.keymap.set("n", "<leader>oo", "<cmd>OverseerToggle<cr>")
            vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<cr>")
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
                    name = cmd,
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
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                        },
                    },
                    view = "mini",
                },
            }
        },
    },

    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        keys = {
            { "<leader>tt", "<cmd>TroubleToggle<cr>", desc = "TroubleToggle" },
        },
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {
            auto_preview = false,
            multiline = false,
        },
    },

    {
        "stevearc/aerial.nvim",
        keys = {
            { "<leader>ot", "<cmd>AerialToggle<cr>", desc = "AerialToggle" },
        },
        opts = {
            layout = {
                default_direction = "float",
            },
            close_on_select = true,
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },

    {
        "/home/bigfix/code/bigfixdev.nvim",
        dev = true,
        config = true,
    },
}
