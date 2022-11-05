local devicons = require'nvim-web-devicons'

-- HACK(andrea): as of right now iTerm2 has limited powerline extra support.
-- In https://gitlab.com/gnachman/iterm2/-/commit/c65295f8d7c2866485cf8336fa4afe0a145870b9
-- was added support for only the characters that in the original repo had an eps file.
-- Not all of the one I wanted were there so I extracted all glyphs from the sfd file to eps from
-- the fontforge cli with:
-- fontforge -lang=ff -c 'Open($1); SelectWorthOutputting(); foreach Export("U+%U.eps"); endloop;' PowerlineExtraSymbols.sfd
-- and copy the eps file I wanted in the (brew --prefix)/Caskroom/iterm2-nightly/latest/iTerm.app/Contents/Resources/
-- renamed as the powerline extra symbols that were thre but that I do not use (like the flame one)
local powerline_extra = {
  up_left_triangle = '', -- \ue0c0 (left-heavy-flame) drawed as \ue0bc (up-left-triangle)
  up_right_trianble = '', -- \ue0c1 (left-thin-flame) drawed as \ue0be (up-right-triangle)
  down_right_triangle = '', -- \ue0ce (left-lego) drawed as \ue0ba (down-right-triangle)
  down_left_triangle = '', -- \ue0cf (up-lego) drawed as \ue0b8 (down-left-triangle)
  thin_up_left_down_right = '', -- \ue0d0 (lego-facing) drawed as \ue0b9
  thin_up_right_down_lft = '' -- \ue0d1 (lego-sideway) drawed as \ue0bb
}

local function separator(current, tabpage)
  local line
    if current == tabpage then
      line = "  "
    else
      line = "  "
    end
    return line .. tabpage .. "  "

end

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

local noname_placeholder = "[No Name]"

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

local function git_branch_component()
  local branch = vim.fn.FugitiveHead(7)
  if branch == nil or branch:len() == 0 then
    return ''
  end
  return table.concat({
    '%5*',
    ' ',
    branch,
    ' ',
    '%4*',
    powerline_extra.up_left_triangle,
  }, '')
end

local function tabline()
  local tl = {}
  table.insert(tl, git_branch_component())
  local current = vim.api.nvim_get_current_tabpage()
  for i, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    table.insert(tl, "%" .. i .. "T") -- Starts mouse click target region
    if current == tabpage then
      table.insert(tl, "%1*")
      table.insert(tl, powerline_extra.down_right_triangle)
      table.insert(tl, "%#TabLineSel#")
      table.insert(tl, "  ")
      table.insert(tl, tabpage)
      table.insert(tl, "  ")
      table.insert(tl, getname(tabpage))
      table.insert(tl, " ")
      table.insert(tl, "%1*")
      table.insert(tl, powerline_extra.down_left_triangle)
    else
      table.insert(tl, "%#TabLine#")
      table.insert(tl, powerline_extra.thin_up_right_down_lft)
      table.insert(tl, "  ")
      table.insert(tl, tabpage)
      table.insert(tl, "  ")
      table.insert(tl, getname(tabpage))
      table.insert(tl, " ")
      table.insert(tl, powerline_extra.thin_up_left_down_right)
    end
  end
  table.insert(tl, "%#TabLine#")
  table.insert(tl, "%T") -- Ends mouse click target region(s).
  return table.concat(tl, '')
end

return { line = tabline }
