return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "folke/neodev.nvim", opts = {} },
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
            -- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

            require("lspconfig.ui.windows").default_options.border = "rounded"

            require("mason-lspconfig").setup {
                automatic_installation = true
            }

            local lspconfig = require("lspconfig")
            local lsp_defaults = lspconfig.util.default_config
            lsp_defaults.capabilities = vim.tbl_deep_extend(
                "force",
                lsp_defaults.capabilities,
                require("cmp_nvim_lsp").default_capabilities()
            )

            lspconfig.gopls.setup {}
            lspconfig.ansiblels.setup {}
            lspconfig.yamlls.setup {}
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                    }
                }
            }

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

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
                end,
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
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
}
