local devicons = require'nvim-web-devicons'
local api = vim.api

local M = {
    ferret_search = nil
}

local function padded(el, n)
  if el ~= nil and #el > 0 then
    n = n or 1
    return el .. (' '):rep(n)
  end
  return ''
end

function M.ferret_search_status()
  return M.ferret_search or ''
end

function M.modified()
  if vim.bo.modified then
    return ' ●'
  end
  return ''
end

function M.ro()
  if vim.bo.readonly then
    return ' '
  end
  return ''
end

function M.is_lsp_available()
  if next(vim.lsp.buf_get_clients(0)) ~= nil then
    return 'LSP '
  end
  return ''
end

local function have_treesitter()
  local bufnr = api.nvim_get_current_buf()
  return vim.treesitter.highlighter.active[bufnr] ~= nil
end

local extract_extension = function(filename)
    local parts = vim.split(filename, "%.")
    local start = #parts
    if start > 2 then
        start = start - 1
    end
    ---@diagnostic disable-next-line: missing-parameter
    return table.concat(vim.list_slice(parts, start), ".")
end

function M.filetype()
  local ft = vim.bo.filetype
  local filename = vim.fs.basename(api.nvim_buf_get_name(0))
  local extension = extract_extension(filename)
  local icon = devicons.get_icon(filename, extension, {default = true})

  if #ft > 0 then
    ft = '['..ft..']'
  else
    ft = ''
  end

  return table.concat({
    padded(icon),
    padded(ft),
    padded(have_treesitter() and '' or nil),
  }, '')
end


-- Returns the 'fileencoding', if it's not UTF-8.
function M.fileencoding()
  local fe = vim.bo.fileencoding
  if #fe > 0 and fe ~= 'utf-8' then
    return '['..fe..']'
  end
  return ''
end

function M.bufname()
  local name = api.nvim_eval_statusline('%f', {}).str -- path of the file
  -- if vim.startswith(name, 'fugitive://') then
  --   local _, _, commit, relpath = name:find([[^fugitive://.*/%.git.-/(.-)/(%x*)]])
  --   name = relpath..'@'..commit:sub(1, 7)
  -- end
  return name
end

local function funcref(ref)
    return '%{v:lua.statusline.'..ref..'()}'
end

local function qf_label(is_qf)
    if is_qf then
        return "Quickfix List"
    else
        return "Location List"
    end
end

local function qf_title(is_qf)
    if is_qf then
        return vim.fn.getqflist({ title = 0 }).title
    else
        return vim.fn.getloclist(0, { title = 0 }).title
    end
end

local function status_line(active)
  if vim.bo.filetype == "qf" then
      local is_qflist = vim.fn.getloclist(0, { filewinid = 1 }).filewinid == 0
      return table.concat({
          '%5*',
          qf_label(is_qflist),
          ' ',
          '%4*',
          '',
          '%*', -- Reset highlight group.
          ' ',
          qf_title(is_qflist),
          '%=',
          '%l/%L',
      }, '')
  end


  if vim.bo.filetype == "DiffviewFiles" then
    return table.concat({
      '%5*',
      "DiffviewFiles",
      ' ',
      '%4*',
      ''
    }, '')
  end

  if not active then
    return '%f%*'
  end

  return table.concat({
    -- [Help] or [Preview] depending on the buffer.
    -- These has been in my status line for a long time, but I'm not sure I
    -- really want/use them.
    '%h%w ',

    -- Where to truncate the line in case of status line too long... Again this
    -- has been here forever and I'm pretty sure that I do not want to only see
    -- the Help/Prevew string (if available)
    '%<',

    funcref('bufname'),
    ' %3*',
    funcref('filetype'),
    '%*',
    '%-4(',
    funcref('modified'),
    funcref('ro'),
    '%)',

    '%*', -- Reset highlight group.
    '%=',

    funcref('ferret_search_status'),
    funcref('is_lsp_available'),

    '%4*', -- Switch to User4 highlight group.
    '',
    '%5*', -- Switch to User5 highlight group.
    ' ',
    funcref('fileencoding'),
    -- XXX(andrea): this is the position in the file
    '%-14(', -- start group (should be 14 char long?)
    '%P ', -- percentage in the file
    '%3l', -- 3 wide padded line (what if the file is longer?)
    'ℓ ', -- (Literal, \u2113 "SCRIPT SMALL L").
    '%02c', -- 2 padded column XXX(andrea): would be better to handle the padding ourselves
    '𝚌 ', -- (Literal, \u1d68c "MATHEMATICAL MONOSPACE SMALL C").
    '%)' -- end group
  }, '')
end

-- XXX(andrea): we should create special statusline for the Quickfix/Location list windows
local function set_status_line(active)
  vim.wo.statusline = status_line(active)
end

local statusline_group = api.nvim_create_augroup('statusline', { clear = true })
api.nvim_create_autocmd('User', {
    pattern = 'FerretAsyncStart',
    callback = function() M.ferret_search = '  ' end,
    group = statusline_group
})

api.nvim_create_autocmd('User', {
    pattern = 'FerretAsyncFinish',
    callback = function() M.ferret_search = nil end,
    group = statusline_group
})

api.nvim_create_autocmd({'WinLeave', 'FocusLost'}, {
    group = statusline_group,
    callback = function()
        set_status_line(false)
    end
})

api.nvim_create_autocmd({'BufWinEnter', 'WinEnter', 'FocusGained'}, {
    group = statusline_group,
    callback = function()
        set_status_line(true)
    end
})

_G.statusline = M

return M
