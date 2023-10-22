local M = {}

---@type table<string,LazyFloat>
local terminals = {}

-- Opens a floating terminal (interactive by default)
---@param cmd? string[]|string
---@param opts? LazyFloatOptions|{interactive?:boolean, cwd: string, toggle_key?:string}
function M.float_term(cmd, opts)
    opts = opts or {}
    opts = vim.tbl_deep_extend("force", {
        interactive = true,
        ft = "lazyterm",
        size = { width = 0.9, height = 0.9 },
    }, opts, { persistent = true })
    ---@cast opts LazyFloatOptions|{interactive: boolean, cwd: string, toggle_key?:string}

    local termkey = vim.inspect { cmd = cmd or "shell", cwd = opts.cwd, count = vim.v.count1 }

    if terminals[termkey] and terminals[termkey]:buf_valid() then
        terminals[termkey]:toggle()
    else
        terminals[termkey] = require("lazy.util").float_term(cmd, opts)
        local buf = terminals[termkey].buf
        vim.b[buf].lazyterm_cmd = cmd

        if opts.toggle_key then
            vim.keymap.set("t", opts.toggle_key, function() terminals[termkey]:toggle() end, { buffer = buf, nowait = true })
        end

        vim.api.nvim_create_autocmd("BufEnter", {
            buffer = buf,
            callback = function()
                vim.cmd.startinsert()
            end,
        })
    end
    return terminals[termkey]
end

return M
