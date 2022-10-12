-- character table string
local N = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

-- encoding
local function base64(data)
  return ((data:gsub('.', function(x)
    local r, b = '', x:byte()
    for i = 8, 1, -1 do
      r = r .. (b % 2^i - b % 2^(i-1) > 0 and '1' or '0')
    end
    return r
  end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
      if #x < 6 then
        return ''
      end
      local c = 0
      for i = 1, 6 do
        c = c + (x:sub(i, i) == '1' and 2^(6 - i) or 0)
      end
      return N:sub(c + 1, c + 1)
    end)..({ '', '==', '=' })[#data%3+1])
end

local function ocs52clipboard()
  local tmux_prefix = ""
  local tmux_postfix = ""
  if vim.env.TMUX ~= nil then
    tmux_prefix = table.concat({
      string.char(0x1b),
      "Ptmux;",
      string.char(0x1b),
    }, '')
    tmux_postfix = table.concat({
      string.char(0x1b),
      string.char(0x5c),
    }, '')
  end

  return function(lines, _)
    local text = table.concat(lines, "\n")
    local ocs52 = table.concat({
      tmux_prefix,
      string.char(0x1b),
      "]52;c;",
      base64(text),
      string.char(0x07),
      tmux_postfix,
    }, '')

    if vim.fn.chansend(vim.v.stderr, ocs52) <= 0 then
      vim.api.nvim_echo({{'Failed to copy selection', 'ErrorMsg'}}, false, {})
    end
  end
end
vim.g.clipboard = {
  name = 'clipper',
  copy = {
    ['+'] = ocs52clipboard(),
    ['*'] = ocs52clipboard(),
  },
  paste = { ['+'] = {}, ['*'] = {} },
  cache_enabled = 1
}

