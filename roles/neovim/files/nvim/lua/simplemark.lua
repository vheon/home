-- Copyright (C) 2021 Andrea Cedraro <a.cedraro@gmail.com>
--
-- Permission is hereby granted, free of charge, to any person obtaining
-- a copy of this software and associated documentation files (the "Software"),
-- to deal in the Software without restriction, including without limitation
-- the rights to use, copy, modify, merge, publish, distribute, sublicense,
-- and/or sell copies of the Software, and to permit persons to whom the
-- Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included
-- in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
-- OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
-- DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
-- OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

-- XXX(andrea): I would prefero to have this into nvim's lua std lib.
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

local function color(nr)
  return vim.g['terminal_color_'..nr] or '#AAA'
end

local function update_simplemark_highlights()
  local background = vim.g.terminal_color_background or '#000'
  vim.cmd("hi SimpleMarkWord1 guifg="..background.." guibg="..color(6))
  vim.cmd("hi SimpleMarkWord2 guifg="..background.." guibg="..color(1))
  vim.cmd("hi SimpleMarkWord3 guifg="..background.." guibg="..color(2))
  vim.cmd("hi SimpleMarkWord4 guifg="..background.." guibg="..color(3))
  vim.cmd("hi SimpleMarkWord5 guifg="..background.." guibg="..color(4))
  vim.cmd("hi SimpleMarkWord6 guifg="..background.." guibg="..color(7))
end

local group = vim.api.nvim_create_augroup('SimpleMarkColors', { clear = true })
vim.api.nvim_create_autocmd( 'Colorscheme', {
  callback = update_simplemark_highlights,
  group = group
})

local function mark_word()
end

local function clear_all()
end

local function setup(opts)
  update_simplemark_highlights()

  vim.keymap.set('n', '<Plug>(SimpleMark)', mark_word )
  vim.keymap.set('n', '<Plug>(SimpleMarkClear)', clear_all )
end

return {
  setup = setup
}
