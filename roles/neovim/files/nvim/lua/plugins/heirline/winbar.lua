local conditions = require "heirline.conditions"

local Breadcrumbs = {
    init = function(self)
        self.opts = {
            max_depth = 5,
            separator = "  ",
            icon = { enabled = true },
        }
    end,
    provider = function(self)
        local data = require("aerial").get_location(true) or {}
        local children = {}

        local start_idx = 0
        -- if self.opts.max_depth > 0 then
        --     start_idx = #data - self.opts.max_depth
        --     if start_idx > 0 then
        --         table.insert(children, { provider = "…" .. self.opts.separator })
        --     end
        -- end
        -- create a child for each level.
        for i, d in ipairs(data) do
            if i > start_idx then
                local child = {
                    {
                        provider = string.gsub(d.name, "%%", "%%%%"):gsub("%s*->%s*", ""),
                    },           -- add symbol name
                }
                table.insert(child, 1, {
                    provider = string.format("%s ", d.icon),
                    hl = string.format("Aerial%sIcon", d.kind)
                })
                if #data > 1 and i < #data then
                    table.insert(child, { provider = self.opts.separator })
                end
                table.insert(children, child)
            end
        end
        -- instantiate the new child.
        self[1] = self:new(children, 1)
    end
}

local FileName = {
    provider = function()
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
        if filename == "" then
            return "[No Name]"
        end

        -- now, if the filename would occupy more than 90% of the available
        -- space, we trim the file path to its initials
        if not conditions.width_percent_below(#filename, 0.90) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename
    end,
}

local devicons = require'nvim-web-devicons'

local FileIcon = {
    init = function(self)
        local extract_extension = function(filename)
            local parts = vim.split(filename, "%.")
            local start = #parts
            if start > 2 then
                start = start - 1
            end
            ---@diagnostic disable-next-line: missing-parameter
            return table.concat(vim.list_slice(parts, start), ".")
        end

        self.filename = vim.api.nvim_buf_get_name(0)
        self.icon = devicons.get_icon(self.filename, extract_extension(self.filename), {default = true})
    end,
    provider = function(self)
        return self.icon and (" " .. self.icon .. " ")
    end
}

local utils = require "heirline.utils"

local Space = { provider = " " }

local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = " ●",
        update = "BufModifiedSet"
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider =  " ", -- ' '
    },
}

local DefaultWinbar = utils.surround({ nil, "" }, "peach", {
    hl = { fg = "mantle" },
    FileName,
    Space,
    FileFlags,
    FileIcon,
})

local InactiveWinbar = {
    condition = conditions.is_not_active,
    FileName,
    Space,
    FileFlags,
    FileIcon,
}


return {
    fallthrough = false,

    InactiveWinbar,
    DefaultWinbar
}
