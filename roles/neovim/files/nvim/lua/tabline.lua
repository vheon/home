local devicons = require'nvim-web-devicons'

local function highlight(current, tabpage)
  if current == tabpage then
    return "%#TabLineSel#"
  end
  return "%#TabLine#"
end

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

local nil_wrap = vim.F.npcall

local function prepadded(el, n)
  if el ~= nil and #el > 0 then
    n = n or 1
    return (' '):rep(n) .. el
  end
  return ''
end


local function getname(tabpage)
  local title = nil_wrap(vim.api.nvim_tabpage_get_var, tabpage, "tab_title")
  if title ~= nil then
    return title
  end

  local filename = extract_filename(vim.api.nvim_tabpage_get_win(tabpage))
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
    return "[No Name]"
  end

  local extension = string.match(filename, '%a+$')
  local icon = devicons.get_icon(filename, extension)
  return filename .. prepadded(icon)
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
    table.insert(tl, highlight(current, tabpage))
    table.insert(tl, separator(current, tabpage))
    table.insert(tl, "%" .. i .. "T") -- Starts mouse click target region
    table.insert(tl, getname(tabpage))
    table.insert(tl, " ")
  end
  table.insert(tl, "%#TabLineFill#")
  table.insert(tl, "%T") -- Ends mouse click target region(s).
  return table.concat(tl, '')
end

return { line = tabline }
