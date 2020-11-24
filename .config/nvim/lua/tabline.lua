local function highlight(current, tabpage)
    if current == tabpage then
      return '%#TabLineSel#'
      -- return '%#Normal#'
    end
    return '%#TabLine#'
    -- return '%#StatusLineNC#'
end

local function separator(current, tabpage)
    if current == tabpage then
      return '▎'
    end
    return ""
end

local function extract_name(win)
  local buf = vim.api.nvim_win_get_buf(win)
  local fullname = vim.api.nvim_buf_get_name(buf)
  if fullname ~= "" then
    return vim.fn.fnamemodify(fullname, ":t")
  end
end

local function getname(tabpage)
  local title = vim.t.tab_title
  if title ~= nil then
    return title
  end

  local win = vim.api.nvim_tabpage_get_win(tabpage)
  local fullname = extract_name(win)
  if fullname ~= nil then
    return fullname
  end
  -- because it was not possible to get the name of the active windows just try
  -- to grab the first name available.
  local wins = vim.api.nvim_tabpage_list_wins(tabpage)
  if #wins > 1 then
    for _, win in ipairs(wins) do
      local fullname = extract_name(win)
      if fullname ~= nil then
        return fullname
      end
    end
  end
  return "[No Name]"
end

local function tabline()
  local line = ''
  local current = vim.api.nvim_get_current_tabpage()
  for i, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    line = line .. highlight(current, tabpage)
    line = line .. '▎'
    line = line .. '%' .. i .. 'T' -- Starts mouse click target region
    line = line .. getname(tabpage)
    line = line .. ' '
  end
  line = line .. '%#TabLineFill#'
  -- line = line .. '%#StatusLineNC#'
  line = line .. '%T' -- Ends mouse click target region(s).
  return line
end

return { line = tabline }
