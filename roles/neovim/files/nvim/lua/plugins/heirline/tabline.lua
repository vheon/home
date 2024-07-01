local logfilename = vim.fs.joinpath(vim.fn.stdpath('log'), 'debug.log')

-- TODO: Ideally the directory should be created in open_logfile(), right
-- before opening the log file, but open_logfile() can be called from libuv
-- callbacks, where using fn.mkdir() is not allowed.
vim.fn.mkdir(vim.fn.stdpath('log'), 'p')

local log_date_format = '%F %H:%M:%S'

--- @type file*?, string?
local logfile, openerr

--- Opens log file. Returns true if file is open, false on error
local function open_logfile()
  -- Try to open file only once
  if logfile then
    return true
  end
  if openerr then
    return false
  end

  logfile, openerr = io.open(logfilename, 'a+')
  if not logfile then
    local err_msg = string.format('Failed to open Debug client log file: %s', openerr)
    vim.notify(err_msg, vim.log.ERROR)
    return false
  end
  logfile:write(string.format('[START][%s] Debug logging initiated\n', os.date(log_date_format)))
  return true
end

local log = {}

--- @return boolean?
log.trace = function(...)
    local argc = select('#', ...)
    if argc == 0 then
        return true
    end
    if not open_logfile() then
        return false
    end
    local info = debug.getinfo(2, 'Sl')
    local header = string.format(
    '[%s] ...%s:%s',
    os.date(log_date_format),
    info.short_src:sub(-16),
    info.currentline
    )
    local parts = { header }
    for i = 1, argc do
        local arg = select(i, ...)
        table.insert(parts, arg == nil and 'nil' or vim.inspect(arg, { newline = '' }))
    end
    assert(logfile)
    logfile:write(table.concat(parts, '\t'), '\n')
    logfile:flush()
end

local conditions = require "heirline.conditions"
local utils = require "heirline.utils"
local devicons = require'nvim-web-devicons'

local g
g = vim.api.nvim_create_autocmd("User", {
    pattern = {"GitSignsUpdate", "GitSignsChanged"},
    callback = function()
        log.trace("from inside the autocmd", vim.g.gitsigns_head)
        if vim.g.gitsigns_head ~= nil then
            vim.api.nvim_del_autocmd(g)
            vim.cmd "redrawtabline"
        end
    end,
})

local GitBranch = {
    -- condition = function()
    --     return vim.g.gitsigns_head ~= nil
    -- end,
    update = {
        "User",
        pattern = {"GitSignsUpdate", "GitSignsChanged"},
        callback = vim.schedule_wrap(function()
            vim.cmd "redrawtabline"
        end)
    },

    hl = "User5",

    {   -- git branch name
        provider = function()
            if vim.g.gitsigns_head ~= nil then
                return table.concat({"  ", vim.g.gitsigns_head, " "}, "")
            end
            if vim.b.gitsigns_head ~= nil then
                return table.concat({"  ", vim.b.gitsigns_head, " "}, "")
            end
        end,
    },
    {
        provider = "",
        hl = "User4"
    }
}

local TabClick = {
    provider = function(self)
        return table.concat({"%", self.tabnr, "T"}, "")
    end,
}

local TabIcon = {
    provider = function(self)
        return self.is_active and "  " or "  "
    end,
}

local TabNumber = {
    provider = function(self)
        return self.tabnr
    end
}

local noname_placeholder = "[Untitled]"

local function extract_filename(win)
  local buf = vim.api.nvim_win_get_buf(win)
  local fullname = vim.api.nvim_buf_get_name(buf)
  if fullname ~= "" then
    return vim.fn.fnamemodify(fullname, ":t")
  end
end

local function prepadded(el, n)
  if el ~= nil and #el > 0 then
    n = n or 1
    return (' '):rep(n) .. el
  end
  return ''
end

local function get_best_window_filename(tabpage, window)
  local filename = extract_filename(window)
  if filename == nil then
    -- because it was not possible to get the name of the active windows just try
    -- to grab the first name available.
    local wins = vim.api.nvim_tabpage_list_wins(tabpage)
    if #wins > 1 then
      for _, win in ipairs(wins) do
        filename = extract_filename(win)
        break
      end
    end
  end

  if filename == nil then
    return noname_placeholder
  end

  local extension = string.match(filename, '%a+$')
  local icon = devicons.get_icon(filename, extension)
  return filename .. prepadded(icon)
end

local function is_float_win(win)
  local config = vim.api.nvim_win_get_config(win)
  return config.zindex and config.zindex > 0
end

local function getname(tabpage)
  -- vim.F.npcall(vim.api.nvim_tabpage_get_var, tabpage, "tab_title")
  local title = vim.t[tabpage].tab_title
  if title ~= nil then
    return title
  end

  local window = vim.api.nvim_tabpage_get_win(tabpage)
  -- Do not replace the last filename-buffer if the window is just a transitory floating window
  if is_float_win(window) then
    return vim.t[tabpage].last_buffer_filename
  end

  local filename = get_best_window_filename(tabpage, window)
  vim.t[tabpage].last_buffer_filename = filename
  return filename
end

local TabName = {
    init = function(self)
        self.tabname = getname(self.tabpage)
    end,
    provider = function(self)
        return self.tabname .. " "
    end
}

local TabPage = utils.insert({
    hl = function(self)
        if not self.is_active then
            return "TabLine"
        else
            return "Error"
        end
    end,
    on_click = { callback = function() end, name = "click" },
}, TabClick, { provider = "" }, TabIcon, TabNumber, { provider = "  " }, TabName, { provider = "" })

local TabPageFill = {
    provider = "",
    hl = "TablineFill"
}

return {
    GitBranch,
    utils.make_tablist(TabPage),
    TabPageFill
}
