return {
    "rebelot/heirline.nvim",
    -- enabled = false,
    dependencies = {
        "lewis6991/gitsigns.nvim",
        "catppuccin/nvim",
        "nvim-tree/nvim-web-devicons",
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local heirline = require "heirline"
        local conditions = require "heirline.conditions"
        heirline.setup {
            statusline = require "plugins.heirline.statusline",
            tabline = require "plugins.heirline.tabline",
            winbar = require "plugins.heirline.winbar",
            opts = {
                colors = require("catppuccin.palettes").get_palette(),
                disable_winbar_cb = function(args)
                    return conditions.buffer_matches({
                        buftype = { "nofile", "prompt", "help", "quickfix", "terminal" },
                        filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
                    }, args.buf)
                end,
            }
        }
    end
}
