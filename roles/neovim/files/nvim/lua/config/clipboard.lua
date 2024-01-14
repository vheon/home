local function copy(register)
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

  local clipboard = register == '+' and 'c' or 'p'
  return function(lines, _)
    local text = table.concat(lines, "\n")
    local ocs52 = table.concat({
      tmux_prefix,
      string.char(0x1b),
      "]52;",
      clipboard,
      ";",
      vim.base64.encode(text),
      string.char(0x07),
      tmux_postfix,
    }, '')

    vim.api.nvim_chan_send(2, ocs52)
  end
end
vim.g.clipboard = {
  name = 'ocs52',
  copy = {
    ['+'] = copy('+'),
    ['*'] = copy('*'),
  },
  paste = { ['+'] = {}, ['*'] = {} },
  cache_enabled = 1
}

