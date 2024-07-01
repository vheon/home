local conditions = require "heirline.conditions"

local function decorate(component, decorators, color)
    local result = {
        {
            hl = { fg = color, bg = "mantle" },
            provider = decorators[1],
        },
        {
            hl = { fg = "mantle", bg = color },
            component
        },
    }
    if decorators[2] ~= nil then
        table.insert(result, {
            hl = { fg = color, bg = "mantle" },
            provider = decorators[2],
        })
    end
    return result
end

local utils = require "heirline.utils"
local devicons = require'nvim-web-devicons'

local Space = { provider = " " }
local Truncate = { provider = "%<" }
local Align = { provider = "%=" }

local MacroRec = {
    condition = function()
        return vim.fn.reg_recording() ~= ""
    end,
    provider = " ",
    hl = { fg = "red", bold = true },
    utils.surround({ "[", "] " }, nil, {
        provider = function()
            return vim.fn.reg_recording()
        end,
    }),
    update = {
        "RecordingEnter",
        "RecordingLeave",
     }
}

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
        return self.icon and (self.icon .. " ")
    end
}

local FileTypeString = {
    provider = function()
        local ft = vim.bo.filetype
        if #ft > 0 then
            return '['..ft..']'
        end
    end,
}

local TreesitterAvailable = {
    provider = '',
    condition = function()
        -- XXX(andrea): is there an easier way?
        -- XXX(andrea): can we attach to some autocmd for Treesitter?
        return vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil
    end
}

local FileType = {
    contition = function()
        return vim.bo.filetype ~= ""
    end,
    FileIcon, FileTypeString, TreesitterAvailable,
    hl = { bg = "mantle", fg = "peach", italic = true }
}


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

local Diagnostics = {

    condition = conditions.has_diagnostics,

    static = {
        icons = require "config.icons".diagnostics
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { "DiagnosticChanged", "BufEnter" },

    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            -- return self.errors > 0 and (self.icons.error .. self.errors .. " ")
            return self.icons.error .. self.errors .. " "
        end,
        hl = "DiagnosticError",
    },
    {
        provider = function(self)
            -- return self.warnings > 0 and (self.icons.warn .. self.warnings .. " ")
            return self.icons.warn .. self.warnings .. " "
        end,
        hl = "DiagnosticWarn",
    },
    {
        provider = function(self)
            -- return self.info > 0 and (self.icons.info .. self.info .. " ")
            return self.icons.info .. self.info .. " "
        end,
        hl = "DiagnosticInfo",
    },
    {
        provider = function(self)
            -- return self.hints > 0 and (self.icons.hint .. self.hints)
            return self.icons.hint .. self.hints
        end,
        hl = "DiagnosticHint",
    },
}

local LspActive = {
    update = { "LspAttach", "LspDetach", "VimResized", "FileType", "BufEnter", "BufWritePost" },
    flexible = 1,
    {
        condition = conditions.lsp_attached,
        init = function(self)
            local names = {}
            for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                table.insert(names, server.name)
            end
            self.servers = " [" ..table.concat(names, " ") .. "] "
        end,
        provider = function(self)
            return self.servers
        end,
    },
    {
        condition = conditions.lsp_attached,
        provider = " [LSP]"
    },
    {
        condition = conditions.lsp_attached,
        provider = " "
    },
}


local FilePosition = {
    provider = table.concat({
        '%-14(', -- start group (should be 14 char long?)
        '%P ', -- percentage in the file
        '%3l', -- 3 wide padded line (what if the file is longer?)
        'ℓ ', -- (Literal, \u2113 "SCRIPT SMALL L").
        '%02c', -- 2 padded column XXX(andrea): would be better to handle the padding ourselves
        '𝚌 ', -- (Literal, \u1d68c "MATHEMATICAL MONOSPACE SMALL C").
        '%)' -- end group
    }, ''),
    hl = "User5"
}

local FileEncoding = {
    provider = function()
        local fe = vim.bo.fileencoding
        if #fe > 0 and fe ~= 'utf-8' then
            return '['..fe..']'
        end
    end
}


local Overseer = {
    static = {
        STATUS = require("overseer.constants").STATUS,
        tasks_count = function(self, status, icon)
            local tasks = self.tasks_by_status[status]
            if tasks then
                return table.concat({icon, #tasks }, "")
            end
        end,
    },

    init = function(self)
        local options = {}
        local tasks = require("overseer.task_list").list_tasks(options)
        self.tasks_by_status = require("overseer.util").tbl_group_by(tasks, "status")
    end,

    {
        provider = function(self)
            return self.tasks_count(self, self.STATUS.FAILURE, " ")
        end,
        hl = { fg = "red", bg = "mantle" }
    },
    {
        provider = function(self)
            return self.tasks_count(self, self.STATUS.CANCELED, " ")
        end,
        hl = { fg = "yellow", bg = "mantle" }
    },
    {
        provider = function(self)
            return self.tasks_count(self, self.STATUS.SUCCESS, " ")
        end,
        hl = { fg = "green", bg = "mantle" }
    },
    {
        provider = function(self)
            return self.tasks_count(self, self.STATUS.RUNNING, "省")
        end,
        hl = { fg = "teal", bg = "mantle" }
    },
}

local Dap = {
    static = {
        dap = require 'dap'
    },
    condition = function(self)
        local session = self.dap.session()
        return session ~= nil
    end,
    init = function(self)
        self.decorated = self:new(decorate({
            provider = 'ﮣ ' .. self.dap.status()
        }, {"", ""}, "blue"))
    end,
    provider = function(self)
        return self.decorated:eval()
    end
}

local Hydra = {
    static = {
        hydra = require 'hydra.statusline',
        color = function(self)
            local color = self.hydra.get_color()
            if color == "amaranth" then
                return "maroon"
            end
            return color
        end
    },
    condition = function(self)
        return self.hydra.is_active()
    end,
    init = function(self)
        self.decorated = self:new(decorate({
            provider = '● ' .. self.hydra.get_name()
        }, {"", ""}, self:color()))
    end,

    provider = function(self)
        return self.decorated:eval()
    end
}

local Bufname = { provider = "%f" }

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

local ferret_search = false
local ferret_group = vim.api.nvim_create_augroup('ferret', { clear = true })
vim.api.nvim_create_autocmd('User', {
    pattern = 'FerretAsyncStart',
    callback = function()
        ferret_search = true
        vim.cmd.redrawstatus()
    end,
    group = ferret_group
})

vim.api.nvim_create_autocmd('User', {
    pattern = 'FerretAsyncFinish',
    callback = function()
        ferret_search = false
        vim.cmd.redrawstatus()
    end,
    group = ferret_group
})

local Ferret = {
    condition = function()
        return ferret_search
    end,
    provider = '  '
}


local DefaultStatusline = {
    MacroRec,
    -- FileName,
    Space,
    FileType,
    FileFlags,
    Align,
    Diagnostics,

    Align,
    Hydra,
    Dap,
    Align,

    Ferret,

    LspActive,
    Overseer,

    decorate({
        Space,
        FileEncoding,
        FilePosition
    }, {""}, "teal"),
}

local InactiveStatusline = {
    condition = conditions.is_not_active,
    -- FileName,
    Align
}

local HelpStatusline = {
    condition = function()
        return conditions.buffer_matches({
            buftype = { "help" },
        })
    end,
    decorate({
        provider = "Help"
    }, {"", ""}, "peach"),
    Align,
    Bufname,
    Align,
    decorate({
        Space,
        FilePosition
    }, {""}, "teal"),
}

local ManStatusline = {
    condition = function()
        return conditions.buffer_matches({
            filetype = { "man" },
        })
    end,
    decorate({
        provider = "Man"
    }, {"", ""}, "peach"),
    Align,
    {
        provider = function()
            return vim.fn.expand('%:t')
        end
    },
    Align,
    decorate({
        Space,
        FilePosition
    }, {""}, "teal"),
}

local QuickfixStatusline = {
    static = {
        is_loclist = function()
            return vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0
        end,
        title = function(is_loclist)
            if is_loclist then
                return vim.fn.getloclist(0, { title = 0 }).title
            end
            return vim.fn.getqflist({ title = 0 }).title
        end
    },
    condition = function()
        return conditions.buffer_matches({
            buftype = { "quickfix" },
        })
    end,
    init = function(self)
        local is_loclist = self.is_loclist()
        self.label = is_loclist and 'Location List' or 'Quickfix List'
        self.t = self.title(is_loclist)
    end,
    decorate({
        provider = function(self)
            return self.label
        end
    }, {"", ""}, "peach"),
    Align,
    {
        provider = function(self)
            return self.t
        end
    },
    Align,
    decorate({
        provider = function()
            local line = vim.fn.line('.')
            local count = vim.fn.line('$')
            return string.format('%3d/%-3d', line, count)
        end
    }, {""}, "peach"),
}

local OilStatusline = {
    static = {
        oil = require "oil"
    },
    condition = function()
        return conditions.buffer_matches({
            filetype = { "oil" },
        })
    end,
    {
        provider = function(self)
            return vim.fn.fnamemodify(self.oil.get_current_dir(), ':~')
        end
    }
}

local TroubleStatusline = {
    condition = function()
        return conditions.buffer_matches({
            filetype = { "Trouble" },
        })
    end,
    static = {
        opts = require('trouble.config').options
    },
    decorate({ provider = "Trouble" }, {"", ""}, "peach"),
    Align,
    {
        provider = function(self)
            return self.opts.mode
        end
    },
    Align,
}

local OverseerListStatusline = {
    condition = function()
        return conditions.buffer_matches({
            filetype = { "OverseerList" },
        })
    end,
    decorate({ provider = 'OverseerList ' }, { nil,"" }, "flamingo")
}

return utils.insert({
        hl = {
            bg = utils.get_highlight("StatusLine").bg,
            fg = utils.get_highlight("StatusLine").fg
        },
        -- the first statusline with no condition, or which condition returns true is used.
        -- think of it as a switch case with breaks to stop fallthrough.
        fallthrough = false,
    },
    QuickfixStatusline,
    HelpStatusline,
    ManStatusline,
    OilStatusline,
    OverseerListStatusline,
    TroubleStatusline,
    InactiveStatusline,
    DefaultStatusline
)
