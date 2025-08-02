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
            graph_style = "kitty",
            signs = {
                section = { "", "" },
                item = { "", "" },
                hunk = { "", "▾" },
            },
        },
    },

    {
        "SuperBo/fugit2.nvim",
        opts = {
            external_diffview = true,
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
            {
                "chrisgrieser/nvim-tinygit", -- optional: for Github PR view
                dependencies = { "stevearc/dressing.nvim" },
            },
        },
        cmd = { "Fugit2", "Fugit2Diff", "Fugit2Graph" },
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
        opts = {
            select = {
                get_config = function(opts)
                    if opts.kind == "overseer_template" then
                        return {
                            backend = "fzf_lua",
                            fzf_lua = {
                                fzf_opts = {
                                    ["--layout"] = "reverse",
                                    ["--info"] = "right",
                                },
                                winopts = {
                                    row = 0.1,
                                    col = 0.5,
                                    height = 0.25,
                                    width = 0.25,
                                },
                            },
                        }
                    end
                end,
            },
        },
    },

    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                -- Customize or remove this keymap to your liking
                "gq",
                function()
                    require("conform").format({ async = true }, function(err)
                        if not err then
                            local mode = vim.api.nvim_get_mode().mode
                            if vim.startswith(string.lower(mode), "v") then
                                vim.api.nvim_feedkeys(
                                    vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                                    "n",
                                    true
                                )
                            end
                        end
                    end)
                end,
                mode = { "n", "v" },
                desc = "Format buffer",
            },
        },
        -- This will provide type hinting with LuaLS
        ---@module "conform"
        ---@type conform.setupOpts
        opts = {
            -- Define your formatters
            formatters_by_ft = {
                lua = { "stylua" },
                cpp = { "clang-format" },
            },
            -- Set default options
            default_format_opts = {
                lsp_format = "fallback",
            },
        },
        init = function()
            -- If you want the formatexpr, here is the place to set it
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
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
        lazy = false,
    },

    { "tpope/vim-unimpaired" },
    { "tpope/vim-abolish" },
    { "tpope/vim-rsi" },

    {
        "saghen/blink.cmp",

        -- use a release tag to download pre-built binaries
        version = "*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            appearance = {
                nerd_font_variant = "mono",
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { "lsp", "path", "buffer" },
            },

            fuzzy = { implementation = "rust" },
        },
        opts_extend = { "sources.default" },
    },

    --{
    --    "hrsh7th/nvim-cmp",
    --    event = "InsertEnter",
    --    dependencies = {
    --        "hrsh7th/cmp-nvim-lsp",
    --        "hrsh7th/cmp-buffer",
    --        "hrsh7th/cmp-path",
    --        "hrsh7th/cmp-nvim-lsp-signature-help",
    --        "hrsh7th/cmp-cmdline",
    --        "L3MON4D3/LuaSnip",
    --        "saadparwaiz1/cmp_luasnip",
    --    },
    --    config = function()
    --        ---@diagnostic disable: need-check-nil
    --        local cmp = require "cmp"
    --        cmp.setup {
    --            snippet = {
    --                expand = function(args)
    --                    require("luasnip").lsp_expand(args.body)
    --                end,
    --            },
    --            window = {
    --                documentation = cmp.config.window.bordered(),
    --            },
    --            sources = {
    --                { name = "nvim_lsp" },
    --                { name = "nvim_lsp_signature_help" },
    --                { name = "luasnip" },
    --                {
    --                    name = "buffer",
    --                    option = {
    --                        get_bufnrs = function()
    --                            return vim.api.nvim_list_bufs()
    --                        end,
    --                    },
    --                },
    --            },
    --            mapping = cmp.mapping.preset.insert {
    --                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    --                ["<C-f>"] = cmp.mapping.scroll_docs(4),
    --                ["<C-Space>"] = cmp.mapping.complete(),
    --            },
    --            experimental = {
    --                ghost_text = true,
    --            },
    --        }
    --        cmp.setup.cmdline(":", {
    --            sources = {
    --                { name = "path" },
    --                { name = "cmdline" },
    --            },
    --            mapping = cmp.mapping.preset.cmdline(),
    --        })
    --    end,
    --},

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
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
    {
        "linrongbin16/gitlinker.nvim",
        cmd = "GitLink",
        keys = {
            {
                "<leader>gl",
                function()
                    require("gitlinker").link { remote = "origin" }
                end,
                silent = true,
                noremap = true,
                desc = "GitLink",
                mode = "v",
            },
        },
        config = function()
            local gitlinker = require "gitlinker"
            gitlinker.setup {
                router = {
                    browse = {
                        ["^github02.hclpnp.com"] = require("gitlinker.routers").github_browse,
                    },
                    blame = {
                        ["^github02.hclpnp.com"] = require("gitlinker.routers").github_blame,
                    },
                },
            }
            vim.keymap.set("v", "<leader>gl", function()
                gitlinker.link { remote = "origin" }
            end, { silent = true, noremap = true, desc = "GitLink" })
        end,
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
        -- config = function(_, opts)
        --     require("bqf").setup(opts)
        -- end,
    },

    {
        "wincent/ferret",
        init = function()
            vim.g.FerretMap = 0
            vim.g.FerretAutojump = 0
        end,
        config = function()
            -- vim.keymap.set("n", "<Leader>sw", ":Ack! -w <C-r><C-w><cr>", { silent = true })
        end,
    },

    {
        "junegunn/fzf",
        build = "./install --xdg --no-update-rc --no-key-bindings --no-completion",
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "ibhagwan/fzf-lua",
        cmd = "FzfLua",
        keys = {
            { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Git Files" },
            { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
            { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
            { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Find Helptags" },
        },
        opts = {
            "telescope",
            fzf_opts = {
                ["--info"] = "default",
                ["--marker"] = "▏",
                ["--pointer"] = "▌",
                ["--prompt"] = "▌ ",
            },
            git = {
                files = {
                    fzf_opts = { ["--scheme"] = "path" },
                    cmd = "git ls-files --exclude-standard --cached --others",
                },
            },
        },
    },

    { "bakpakin/fennel.vim" },

    { "pprovost/vim-ps1" },
    -- { "pearofducks/ansible-vim" },
    { "mfussenegger/nvim-ansible" },

    {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        config = true,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        keys = {
            {
                "yoC",
                function()
                    require("treesitter-context").toggle()
                end,
                mode = "n",
                { desc = "Toggle Treesitter Context" },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufReadPost",
        cmd = { "TSUpdate" },
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
                    "query",
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
        keys = {
            {
                "<A-j>",
                function()
                    require("dap").step_over()
                end,
                { desc = "step over" },
            },
            {
                "<A-i>",
                function()
                    require("dap").step_into()
                end,
                { desc = "step into" },
            },
            {
                "<A-I>",
                function()
                    require("dap").step_into {
                        askForTargets = true,
                    }
                end,
                { desc = "step into specific" },
            },
            {
                "<A-o>",
                function()
                    require("dap").step_out()
                end,
                { desc = "step out" },
            },
            {
                "<A-s>",
                function()
                    require("dap").continue()
                end,
                { desc = "Continue/Start" },
            },
            {
                "<A-j>",
                function()
                    require("dap").run_to_cursor()
                end,
                { desc = "to cursor" },
            },
            {
                "<A-S-s>",
                function()
                    require("dap").terminate()
                end,
                { desc = "terminate" },
            },
            {
                "<A-U>",
                function()
                    require("dapui").toggle()
                end,
                { desc = "Toggle UI" },
            },
            {
                "<A-b>",
                function()
                    require("dap").toggle_breakpoint()
                end,
                { desc = "Breakpoint" },
            },
            -- {
            --     "L",
            --     function()
            --         vim.ui.input({ prompt = "Log point message: " }, function(input)
            --             require("dap").set_breakpoint(nil, nil, input)
            --         end)
            --     end,
            --     { desc = "Add Log Point" },
            -- },
            {
                "<A-K>",
                function()
                    require("dap.ui.widgets").hover()
                end,
                { desc = "Eval" },
            },
        },
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
            require("overseer").enable_dap()
            require("dap.ext.vscode").json_decode = require("overseer.json").decode
            local dap = require "dap"
            dap.set_log_level "TRACE"
            dap.adapters.gdb = {
                id = "gdb",
                type = "executable",
                command = "gdb",
                args = { "--quiet", "--interpreter=dap", "--eval-command", "set print pretty on" },
            }
            dap.adapters.codelldb = {
                type = "executable",
                command = "codelldb",
            }
            dap.adapters.lldb = {
                type = "executable",
                command = "lldb-vscode-14",
            }

            local dap_utils = require "dap.utils"

            local programFn = function()
                return coroutine.create(function(dap_run_co)
                    vim.ui.input({
                        prompt = "Path to executable: ",
                        default = vim.fn.getcwd() .. "/",
                        completion = "file",
                    }, function(path)
                        coroutine.resume(dap_run_co, (path and path ~= "") and path or dap.ABORT)
                    end)
                end)
            end

            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = programFn,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = true,
                },
                {
                    name = "Select and attach to process",
                    type = "gdb",
                    request = "attach",
                    program = programFn,
                    pid = function()
                        return coroutine.create(function(dap_run_co)
                            local process = require("dap.utils").pick_process()
                            coroutine.resume(dap_run_co, process)
                        end)
                    end,
                    cwd = "${workspaceFolder}",
                },
                {
                    name = "Run executable with arguments (GDB)",
                    type = "gdb",
                    request = "launch",
                    -- This requires special handling of 'run_last', see
                    -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
                    program = programFn,
                    args = function()
                        return coroutine.create(function(dap_run_co)
                            vim.ui.input({
                                prompt = "Arguments: ",
                            }, function(args_str)
                                local arguments = (args_str and args_str ~= "") and vim.split(args_str, " +")
                                    or dap.ABORT
                                coroutine.resume(dap_run_co, arguments)
                            end)
                        end)
                    end,
                    cwd = "${workspaceFolder}",
                },
                {
                    name = "Run executable (GDB Server)",
                    type = "gdb",
                    request = "attach",
                    -- This requires special handling of 'run_last', see
                    -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
                    target = function()
                        return coroutine.create(function(dap_run_co)
                            vim.ui.input({
                                prompt = "Target: ",
                            }, function(args_str)
                                local arguments = args_str or dap.ABORT
                                coroutine.resume(dap_run_co, arguments)
                            end)
                        end)
                    end,
                    program = function()
                        return dap_utils.pick_file {
                            path = string.format("%s/BES/ProjectFiles/Unix", vim.fn.getcwd()),
                            executables = true,

                            filter = function(exec)
                                -- Filter out shared libraries
                                return not exec:match "%.o"
                            end,
                        }
                    end,
                },
            }
        end,
    },
    {
        "leoluz/nvim-dap-go",
        -- lazy = true,
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
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = true,
    },
    {
        -- Temporary fork with a fix for nightly
        "Cathyprime/hydra.nvim",
        -- "nvimtools/hydra.nvim",
        keys = "<leader>dh",
        config = function()
            local Hydra = require "hydra"

            -- XXX(andrea): this is wrong! either fix it or just use the generated one
            --[[[
            local hint = [[
 _n_: step over   _s_: Continue/Start   _b_: Breakpoint     _K_: Eval
 _i_: step into   _U_: Toggle UI        ^ ^                 ^ ^
 _o_: step out    _X_: Terminate        ^ ^
 _c_: to cursor
 ^
 ^ ^              _q_: exit
]]
            --]]]

            local dh = Hydra {
                config = {
                    color = "pink",
                    on_enter = function()
                        vim.bo.modifiable = false
                    end,
                    invoke_on_body = true,
                    -- hint = hint,
                    hint = {
                        type = "window",
                        position = "bottom",
                        float_opts = {
                            border = "rounded",
                        },
                    },
                },
                name = "dap",
                mode = { "n", "x" },
                body = "<leader>dh",
                heads = {
                    {
                        "<Down>",
                        function()
                            require("dap").step_over()
                        end,
                        { desc = "step over" },
                    },
                    {
                        "<Up>",
                        function()
                            require("dap").step_back()
                        end,
                        { desc = "step back" },
                    },
                    {
                        "<Right>",
                        function()
                            require("dap").step_into()
                        end,
                        { desc = "step into" },
                    },
                    {
                        "<Left>",
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
                blink_cmp = true,
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

                    SimpleMarkWord1 = { fg = colors.base, bg = colors.teal },
                    SimpleMarkWord2 = { fg = colors.base, bg = colors.red },
                    SimpleMarkWord3 = { fg = colors.base, bg = colors.green },
                    SimpleMarkWord4 = { fg = colors.base, bg = colors.yellow },
                    SimpleMarkWord5 = { fg = colors.base, bg = colors.blue },
                    SimpleMarkWord6 = { fg = colors.base, bg = colors.lavender },
                }
            end,
        },
    },

    {
        "stevearc/overseer.nvim",
        config = function()
            local overseer = require "overseer"
            overseer.setup {
                dap = false, -- we will enable dap support manually when nvim-dap is loaded
                default_template_prompt = "allow",
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
                        { "on_complete_dispose", timeout = 10 },
                        "default",
                    },
                }
                task:start()
            end, { nargs = "*", bang = true })
            vim.keymap.set("n", "<Leader>sw", ":Grep -w <C-r><C-w><cr>", { silent = true })
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
            },
        },
    },

    {
        "folke/trouble.nvim",
        cmd = { "Trouble" },
        keys = {
            { "<leader>td", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
            { "<leader>tq", "<cmd>Trouble quickfix toggle<cr>", desc = "Quickfix (Trouble)" },
        },
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {
            auto_preview = false,
            follow = false,
            modes = {
                diagnostics = {
                    sort = { "severity", "filename", "pos", "message" },
                },
            },
        },
    },
    --{
    --    "stevearc/quicker.nvim",
    --    event = "FileType qf",
    --    ---@module "quicker"
    --    ---@type quicker.SetupOptions
    --    opts = {},
    --    init = function()
    --        vim.keymap.set("n", "<leader>q", function()
    --            require("quicker").toggle()
    --        end, { desc = "Toggle quickfix", })
    --    end
    --},

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show { global = false }
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
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
        "OXY2DEV/markview.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            preview = {
                modes = { "n", "i", "no", "c" },
                hybrid_modes = { "i" },
                -- This is nice to have
                callbacks = {
                    on_enable = function(_, win)
                        vim.wo[win].conceallevel = 2
                        vim.wo[win].concealcursor = "nc"
                    end,
                },
            },
        },
    },

    {
        "madskjeldgaard/cppman.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = true,
    },

    { "rafcamlet/nvim-luapad" },
    { "stevearc/profile.nvim" },

    {
        dir = "/home/bigfix/code/bigfixdev.nvim",
        opts = {},
    },

    {
        "kndndrj/nvim-dbee",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        build = function()
            -- Install tries to automatically detect the install method.
            -- if it fails, try calling it with one of these parameters:
            --    "curl", "wget", "bitsadmin", "go"
            require("dbee").install()
        end,
        config = function()
            require("dbee").setup()
        end,
    },
    {
        "mistweaverco/kulala.nvim",
        ft = { "http", "rest" },
        opts = {
            -- your configuration comes here
            global_keymaps = false,
            additional_curl_options = { "--insecure" },
        },
    },
    {
        "rbong/vim-flog",
        lazy = true,
        cmd = { "Flog", "Flogsplit", "Floggit" },
        dependencies = {
            "tpope/vim-fugitive",
        },
        config = function()
            vim.g.flog_enable_extended_chars = true
            vim.g.flog_enable_dynamic_commit_hl = true
        end
    },
}
