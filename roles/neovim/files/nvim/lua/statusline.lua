local devicons = require'nvim-web-devicons'

local function define_highlights(groups)
  for group, spec in pairs(groups) do
    local gui = spec.gui and 'gui='..spec.gui or ''
    vim.cmd(table.concat({
      'highlight',
      tostring(group),
      'guibg='..spec.guibg,
      'guifg='..spec.guifg,
      gui
    }, ' '))
  end
end


local function define_highlight_groups()
  define_highlights {
    StatusLine = {
      guibg = '#343d46',
      guifg = '#d8dee9',
      gui = 'bold'
    },
    User2 = {
      guibg = '#343d46',
      guifg = '#ffffff',
      gui = 'bold'
    },
    User3 = {
      guibg = '#343d46',
      guifg = '#d8dee9',
      gui = 'italic'
    },
    User4 = {
      guibg = '#343d46',
      guifg = '#d8dee9'
    },
    User5 = {
      guibg = '#d8dee9',
      guifg = '#1b2b34',
      gui = 'bold'
    }
  }
end

local function setup()
  local statusline_group = vim.api.nvim_create_augroup('vim_statusline', { clear = true })
  vim.api.nvim_create_autocmd( 'User', {
    pattern = 'FerretAsyncStart',
    callback = function() vim.g.ferret_search = '  ' end,
    group = statusline_group
  })
  vim.api.nvim_create_autocmd( 'User', {
    pattern = 'FerretAsyncFinish',
    callback = function() vim.g.ferret_search = nil end,
    group = statusline_group
  })

  vim.api.nvim_create_autocmd( 'ColorScheme', {
    callback = define_highlight_groups,
    group = statusline_group
  })

  define_highlight_groups()
end

local function git_branch()
  local branch = vim.fn.FugitiveHead(7)
  if branch ~= nil and branch:len() > 0 then
    return ' '..branch
  end
  return ''
end

local function ferret_search_status()
  return vim.g.ferret_search or ''
end

local function modified()
  if vim.bo.modified then
    return ' ✘' -- HEAVY BALLOT X - Unicode: U+2718, UTF-8: E2 9C 98
  end
  return ''
end

local function ro()
  if vim.bo.readonly then
    return ' '
  end
  return ''
end

local function ycm_status()
  if not vim.b.ycm_enabled then
    return ' '
  end
  return ''
end

local function padding(el, n)
  if el ~= nil and #el > 0 then
    n = n or 1
    return (' '):rep(n)
  end
  return ''
end

local function filetype()
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')
  local extension = string.match(filename, '%a+$')

  local ft = vim.bo.filetype
  if #ft > 0 then
    ft = '['..ft..']'
  end

  local icon = devicons.get_icon(filename, extension) or ''
  return table.concat({
    icon,
    padding(icon),
    '%3*',
    ft,
    padding(ft),
    '%*'
  }, '')
end

-- Returns the 'fileencoding', if it's not UTF-8.
local function fileencoding()
  local fileencoding = vim.bo.fileencoding
  if #fileencoding > 0 and fileencoding ~= 'utf-8' then
    return '['..fileencoding..']'
  end
  return ''
end

-- XXX(andrea): we should create special statusline for the Quickfix/Location list windows
local function status_line()
  -- If we're rendering a non focused window just put the file path
  if vim.g.statusline_winid ~= vim.fn.win_getid() then
    return '%f%*'..git_branch()
  end

  return table.concat({
    -- line = line .. '%4*' -- Switch to User4 highlight group.
    -- line = line .. ''
    -- line = line .. '%*'

    -- [Help] or [Preview] depending on the buffery.
    -- These has been in my status line for a long time, but I'm not sure I
    -- really want/use them.
    '%h%w ',

    -- Where to truncate the line in case of status line too long... Again this
    -- has been here forever and I'm pretty sure that I do not want to only see
    -- the Help/Prevew string (if available)
    '%<',

    '%2*',
    '%f', -- path of the file
    '%*',
    git_branch(),
    ferret_search_status(),
    '%-4(',
    modified(),
    ro(),
    '%)',

    '%*', -- Reset highlight group.
    '%=',

    ycm_status(),
    filetype(),

    '%4*', -- Switch to User4 highlight group.
    '',
    '%5*', -- Switch to User5 highlight group.
    ' ',
    fileencoding(),
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

setup()

return { line = status_line }
