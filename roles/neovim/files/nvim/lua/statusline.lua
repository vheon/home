local devicons = require'nvim-web-devicons'
local mocha = require("catppuccin.palettes").get_palette "mocha"


local function define_highlight_groups()
  --  catppuccin
  -- vim.api.nvim_set_hl(0, "User1", { bg = mocha.mantle, fg = mocha.surface1,  bold = true })
  -- vim.api.nvim_set_hl(0, "User2", { bg = mocha.base, fg = mocha.green,  bold = true })

  vim.api.nvim_set_hl(0, "User3", { bg = mocha.mantle, fg = mocha.peach,  italic = true })
  vim.api.nvim_set_hl(0, "User4", { bg = mocha.mantle, fg = mocha.teal })
  vim.api.nvim_set_hl(0, "User5", { bg = mocha.teal, fg = mocha.base,  bold = true })
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

local function padded(el, n)
  if el ~= nil and #el > 0 then
    n = n or 1
    return el .. (' '):rep(n)
  end
  return ''
end

local function git_branch()
  local branch = vim.fn.FugitiveHead(7)
  if branch ~= nil and branch:len() > 0 then
    return branch
  end
  return nil
end

local function git_branch_component()
  local branch = git_branch()
  if branch == nil then
    return ''
  end

  return table.concat({
    '%5*',
    ' ',
    branch,
    ' ',
    '%4*',
    ''
  }, '')
end

local function ferret_search_status()
  return vim.g.ferret_search or ''
end

local function modified()
  if vim.bo.modified then
    return ' ●'
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

local function is_lsp_available()
  if next(vim.lsp.buf_get_clients(0)) ~= nil then
    return 'LSP '
  end
  return ''
end

local function filetype()
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')
  local extension = string.match(filename, '%a+$')

  local icon = devicons.get_icon(filename, extension)

  local ft = vim.bo.filetype
  if #ft > 0 then
    ft = '['..ft..']'
  else
    ft = nil
  end

  return table.concat({
    '%3*',
    padded(ft),
    padded(icon),
    '%*'
  }, '')
end


-- Returns the 'fileencoding', if it's not UTF-8.
local function fileencoding()
  local fe = vim.bo.fileencoding
  if #fe > 0 and fe ~= 'utf-8' then
    return '['..fe..']'
  end
  return ''
end

-- XXX(andrea): we should create special statusline for the Quickfix/Location list windows
local function status_line()
  -- If we're rendering a non focused window just put the file path
  if vim.g.statusline_winid ~= vim.fn.win_getid() then
    local components = {'%f', '%*'}
    local branch = git_branch()
    if branch ~= nil then
      table.insert(components, ' ')
      table.insert(components, branch)
      table.insert(components, ' ')
    end
    return table.concat(components, '')
  end

  return table.concat({
    git_branch_component(),
    '%*',

    -- [Help] or [Preview] depending on the buffery.
    -- These has been in my status line for a long time, but I'm not sure I
    -- really want/use them.
    '%h%w ',


    -- Where to truncate the line in case of status line too long... Again this
    -- has been here forever and I'm pretty sure that I do not want to only see
    -- the Help/Prevew string (if available)
    '%<',

    '%2*',
    filetype(),
    '%f', -- path of the file
    '%*',
    '%-4(',
    modified(),
    ro(),
    '%)',

    '%*', -- Reset highlight group.
    '%=',

    ferret_search_status(),
    is_lsp_available(),

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
