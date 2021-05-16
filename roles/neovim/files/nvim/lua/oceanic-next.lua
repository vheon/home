vim.o.background = 'dark'
vim.cmd 'hi clear'

if vim.fn.exists("syntax_on") then
  vim.cmd 'syntax reset'
end

vim.o.termguicolors = true
vim.g.colors_name = "OceanicNext"

local italic = "italic"
local bold = "bold"

local colors = {
  base00 = '#1b2b34',
  base01 = '#343d46',
  base02 = '#4f5b66',
  base03 = '#65737e',
  base04 = '#a7adba',
  base05 = '#c0c5ce',
  base06 = '#cdd3de',
  base07 = '#d8dee9',
  red    = '#ec5f67',
  orange = '#f99157',
  yellow = '#fac863',
  green  = '#99c794',
  cyan   = '#62b3b2',
  blue   = '#6699cc',
  purple = '#c594c5',
  brown  = '#ab7967',
  white  = '#ffffff',
  none   = 'NONE'
}
colors.bg = colors.base00
colors.text = colors.white -- In https://github.com/mhartington/oceanic-next is base07 right now


-- XXX(andrea): the majority of the groups have just the `fg` entry. Maybe we should make the structure something like:
--
-- GroupName = { fgcolor, bg = colors.bg, gui = 'underline' }
local function define_highlights(groups)
  for group, spec in pairs(groups) do
    local fg = spec.fg and 'guifg='..spec.fg or ''
    local bg = spec.bg and 'guibg='..spec.bg or ''
    local gui = spec.gui and 'gui='..spec.gui or ''
    local attrsp = spec.attrsp and 'guisp='..spec.attrsp or ''
    vim.cmd(table.concat({ 'hi', tostring(group), fg, bg, gui, attrsp }, ' '))
  end
end

define_highlights({
  Bold = { gui = bold },
  Debug = { fg = colors.red },
  Directory = { fg = colors.blue },
  ErrorMsg = { fg = colors.red, bg = colors.base00 },
  Exception = { fg = colors.red },
  FoldColumn = { fg = colors.blue, bg = colors.base00 },
  Folded = { fg = colors.base03, bg = colors.base01, gui = italic },
  IncSearch = { fg = colors.base01, bg = colors.orange, gui = 'NONE' },
  Italic = { gui = italic },

  Macro = { fg = colors.red },
  MatchParen = { fg = colors.base05, bg = colors.base03 },
  ModeMsg = { fg = colors.green },
  MoreMsg = { fg = colors.green },
  Question = { fg = colors.blue },
  Search = { fg = colors.base03, bg = colors.yellow },
  SpecialKey = { fg = colors.base03 },
  TooLong = { fg = colors.red },
  Underlined = { fg = colors.red },
  Visual = { colorbg = colors.base02 },
  VisualNOS = { fg = colors.red },
  WarningMsg = { fg = colors.red },
  WildMenu = { fg = colors.text, bg = colors.blue },
  Title = { fg = colors.blue },
  Conceal = { fg = colors.blue, bg = colors.base00 },
  Cursor = { fg = colors.base00, bg = colors.base05 },
  NonText = { fg = colors.base03 },
  Normal = { fg = colors.text, bg = colors.base00 },
  EndOfBuffer = { fg = colors.base05, bg = colors.base00 },
  LineNr = { fg = colors.base03, bg = colors.base00 },
  SignColumn = { fg = colors.base00, bg = colors.base00 },
  StatusLine = { fg = colors.base01, bg = colors.base07 },
  StatusLineNC = { fg = colors.base03, bg = colors.base01 },
  VertSplit = { fg = colors.base00, bg = colors.base02 },
  ColorColumn = { bg = colors.base01 },
  CursorColumn = { bg = colors.base01 },
  CursorLine = { bg = colors.base01, gui = 'None' },
  CursorLineNR = { fg = colors.base00, bg = colors.base00 },
  CursorLineNr = { fg = colors.base03, bg = colors.base01 },
  PMenu = { fg = colors.base04, bg = colors.base01 },
  PMenuSel = { fg = colors.text, bg = colors.blue },
  PmenuSbar = { bg = colors.base02 },
  PmenuThumb = { bg = colors.base07 },
  TabLine = { fg = colors.base03, bg = colors.base01 },
  TabLineFill = { fg = colors.base03, bg = colors.base01 },
  TabLineSel = { fg = colors.green, bg = colors.base01 },
  helpExample = { fg = colors.yellow },
  helpCommand = { fg = colors.yellow },

  -- Standard syntax highlighting
  Boolean = { fg = colors.orange },
  Character = { fg = colors.red },
  Comment = { fg = colors.base03, gui = italic },
  Conditional = { fg = colors.purple },
  Constant = { fg = colors.orange },
  Define = { fg = colors.purple },
  Delimiter = { fg = colors.brown },
  Float = { fg = colors.orange },
  Function = { fg = colors.blue },

  Identifier = { fg = colors.cyan },
  Include = { fg = colors.blue },
  Keyword = { fg = colors.purple },

  Label = { fg = colors.yellow },
  Number = { fg = colors.orange },
  Operator = { fg = colors.base05 },
  PreProc = { fg = colors.yellow },
  Repeat = { fg = colors.yellow },
  Special = { fg = colors.cyan },
  SpecialChar = { fg = colors.brown },
  Statement = { fg = colors.red },
  StorageClass = { fg = colors.yellow },
  String = { fg = colors.green },
  Structure = { fg = colors.purple },
  Tag = { fg = colors.yellow },
  Todo = { fg = colors.yellow, bg = colors.base01 },
  Type = { fg = colors.yellow },
  Typedef = { fg = colors.yellow },

  -- LSP
  LspDiagnosticsDefaultError = { },
  LspDiagnosticsSignError = { fg = colors.red },
  LspDiagnosticsUnderlineError = { gui = 'undercurl' },

  LspDiagnosticsDefaultWarning = { },
  LspDiagnosticsSignWarning = { fg = colors.yellow },
  LspDiagnosticsUnderlineWarning = { gui = 'undercurl' },

  LspDiagnosticsDefaultInformation = { },
  LspDiagnosticsSignInformation = { fg = colors.blue },
  LspDiagnosticsUnderlineInformation = { gui = 'undercurl' },

  LspDiagnosticsDefaultHint = { },
  LspDiagnosticsSignHint = { fg = colors.cyan },
  LspDiagnosticsUnderlineHint = { gui = 'undercurl' },


  -- TreeSitter stuff
  TSInclude = { fg = colors.cyan },
  TSPunctBracket = { fg = colors.cyan },
  TSPunctDelimiter = { fg = colors.text },
  TSParameter = { fg = colors.text },
  TSType = { fg = colors.blue },
  TSFunction = { fg = colors.cyan },

  TSTagDelimiter = { fg = colors.cyan },
  TSProperty = { fg = colors.yellow },
  TSMethod = { fg = colors.blue },
  TSParameter = { fg = colors.yellow },
  TSConstructor = { fg = colors.text },
  TSVariable = { fg = colors.text },
  TSOperator = { fg = colors.text },
  TSTag = { fg = colors.text },
  TSKeyword = { fg = colors.purple },
  TSKeywordOperator = { fg = colors.purple },
  TSVariableBuiltin = { fg = colors.red },
  TSLabel = { fg = colors.cyan },

  TSText = { fg = colors.text },    -- For strings considered text in a markup language.
  TSTextReference = { fg = colors.yellow }, -- FIXME
  TSEmphasis = { fg = '#FF0000' },    -- For text to be represented with emphasis.
  TSUnderline = { fg = colors.text, bg = colors.none, style = 'underline' },    -- For text to be represented with an underline.

  SpellBad = { gui = 'undercurl' },
  SpellLocal = { gui = 'undercurl' },
  SpellCap = { gui = 'undercurl' },
  SpellRare = { gui = 'undercurl' },

  csClass = { fg = colors.yellow },
  csAttribute = { fg = colors.yellow },
  csModifier = { fg = colors.purple },
  csType = { fg = colors.red },
  csUnspecifiedStatement = { fg = colors.blue },
  csContextualStatement = { fg = colors.purple },
  csNewDecleration = { fg = colors.red },
  cOperator = { fg = colors.cyan },
  cPreCondit = { fg = colors.purple },

  cssColor = { fg = colors.cyan },
  cssBraces = { fg = colors.base05 },
  cssClassName = { fg = colors.purple },


  DiffAdd = { fg = colors.green, bg = colors.base01, gui = bold },
  DiffChange = { fg = colors.base03, bg = colors.base01 },
  DiffDelete = { fg = colors.red, bg = colors.base01 },
  DiffText = { fg = colors.blue, bg = colors.base01 },
  DiffAdded = { fg = colors.text, bg = colors.green, gui = bold },
  DiffFile = { fg = colors.red, bg = colors.base00 },
  DiffNewFile = { fg = colors.green, bg = colors.base00 },
  DiffLine = { fg = colors.blue, bg = colors.base00 },
  DiffRemoved = { fg = colors.text, bg = colors.red, gui = bold },

  gitCommitOverflow = { fg = colors.red },
  gitCommitSummary = { fg = colors.green },

  htmlBold = { fg = colors.yellow },
  htmlItalic = { fg = colors.purple },
  htmlTag = { fg = colors.cyan },
  htmlEndTag = { fg = colors.cyan },
  htmlArg = { fg = colors.yellow },
  htmlTagName = { fg = colors.text },

  javaScript = { fg = colors.base05 },
  javaScriptNumber = { fg = colors.orange },
  javaScriptBraces = { fg = colors.base05 },

  jsonKeyword = { fg = colors.green },
  jsonQuote = { fg = colors.green },

  markdownCode = { fg = colors.green },
  markdownCodeBlock = { fg = colors.green },
  markdownHeadingDelimiter = { fg = colors.blue },
  markdownItalic = { fg = colors.purple, gui = italic },
  markdownBold = { fg = colors.yellow, gui = bold },
  markdownCodeDelimiter = { fg = colors.brown, gui = italic },
  markdownError = { fg = colors.base05, bg = colors.base00 },

  typescriptParens = { fg = colors.base05, bg = colors.none },

  -- NeomakeErrorSign = { fg = colors.red, bg = colors.base00 },
  -- NeomakeWarningSign = { fg = colors.yellow, bg = colors.base00 },
  -- NeomakeInfoSign = { fg = colors.white, bg = colors.base00 },
  -- NeomakeError = { fg = colors.red, gui = 'underline', attrsp = colors.red },
  -- NeomakeWarning = { fg = colors.red, gui = 'underline', attrsp = colors.red },

  -- ALEErrorSign = { fg = colors.red, bg = colors.base00, gui = bold },
  -- ALEWarningSign = { fg = colors.yellow, bg = colors.base00, gui = bold },
  -- ALEInfoSign = { fg = colors.white, bg = colors.base00, gui = bold },

  -- NERDTreeExecFile = { fg = colors.base05 },
  -- NERDTreeDirSlash = { fg = colors.blue },
  -- NERDTreeOpenable = { fg = colors.blue },
  -- NERDTreeFile = { bg = colors.none },
  -- NERDTreeFlags = { fg = colors.blue },

  phpComparison = { fg = colors.base05 },
  phpParent = { fg = colors.base05 },
  phpMemberSelector = { fg = colors.base05 },

  pythonRepeat = { fg = colors.purple },
  pythonOperator = { fg = colors.purple },

  rubyConstant = { fg = colors.yellow },
  rubySymbol = { fg = colors.green },
  rubyAttribute = { fg = colors.blue },
  rubyInterpolation = { fg = colors.green },
  rubyInterpolationDelimiter = { fg = colors.brown },
  rubyStringDelimiter = { fg = colors.green },
  rubyRegexp = { fg = colors.cyan },

  -- sassidChar = { fg = colors.red },
  -- sassClassChar = { fg = colors.orange },
  -- sassInclude = { fg = colors.purple },
  -- sassMixing = { fg = colors.purple },
  -- sassMixinName = { fg = colors.blue },

  vimfilerLeaf = { fg = colors.base05 },
  vimfilerNormalFile = { fg = colors.base05, bg = colors.base00 },
  vimfilerOpenedFile = { fg = colors.blue },
  vimfilerClosedFile = { fg = colors.blue },

  GitGutterAdd = { fg = colors.green, bg = colors.base00, gui = bold },
  GitGutterChange = { fg = colors.blue, bg = colors.base00, gui = bold },
  GitGutterDelete = { fg = colors.red, bg = colors.base00, gui = bold },
  GitGutterChangeDelete = { fg = colors.purple, bg = colors.base00, gui = bold },

  SignifySignAdd = { fg = colors.green, bg = colors.base00, gui = bold },
  SignifySignChange = { fg = colors.blue, bg = colors.base00, gui = bold },
  SignifySignDelete = { fg = colors.red, bg = colors.base00, gui = bold },
  SignifySignChangeDelete = { fg = colors.purple, bg = colors.base00, gui = bold },
  SignifySignDeleteFirstLine = { fg = colors.red, bg = colors.base00, gui = bold },

  xmlTag = { fg = colors.cyan },
  xmlTagName = { fg = colors.base05 },
  xmlEndTag = { fg = colors.cyan },
  Defx_filename_directory = { fg = colors.blue },

  -- CocErrorSign = { fg = colors.red },
  -- CocWarningSign = { fg = colors.yellow },
  -- CocInfoSign = { fg = colors.blue },
  -- CocHintSign = { fg = colors.cyan },
  -- CocErrorFloat = { fg = colors.red },
  -- CocWarningFloat = { fg = colors.yellow },
  -- CocInfoFloat = { fg = colors.blue },
  -- CocHintFloat = { fg = colors.cyan },
  -- CocDiagnosticsError = { fg = colors.red },
  -- CocDiagnosticsWarning = { fg = colors.yellow },
  -- CocDiagnosticsInfo = { fg = colors.blue },
  -- CocDiagnosticsHint = { fg = colors.cyan },
  -- CocSelectedText = { fg = colors.purple },
  -- CocCodeLens = { fg = colors.base04 }

    User2 = { fg = colors.white, bg = colors.base01, gui = bold },
    User3 = { fg = colors.base07, bg = colors.base01, gui = italic },
    User4 = { fg = colors.white, bg = colors.base01 },
    User5 = { fg = colors.base00, bg = colors.white, gui = bold },

  SimpleMarkWord1 = { fg = colors.bg, bg = colors.cyan },
  SimpleMarkWord2 = { fg = colors.bg, bg = colors.red },
  SimpleMarkWord3 = { fg = colors.bg, bg = colors.green },
  SimpleMarkWord4 = { fg = colors.bg, bg = colors.yellow },
  SimpleMarkWord5 = { fg = colors.bg, bg = colors.blue },
  SimpleMarkWord6 = { fg = colors.bg, bg = colors.base05 }
})

vim.g.terminal_color_0 = colors.base00
vim.g.terminal_color_8 = colors.base03

vim.g.terminal_color_1 = colors.red
vim.g.terminal_color_9 = colors.red

vim.g.terminal_color_2 = colors.green
vim.g.terminal_color_10 = colors.green

vim.g.terminal_color_3 = colors.yellow
vim.g.terminal_color_11 = colors.yellow

vim.g.terminal_color_4 = colors.blue
vim.g.terminal_color_12 = colors.blue

vim.g.terminal_color_5 = colors.purple
vim.g.terminal_color_13 = colors.purple

vim.g.terminal_color_6 = colors.cyan
vim.g.terminal_color_14 = colors.cyan

vim.g.terminal_color_7 = colors.base05
vim.g.terminal_color_15 = colors.base05

vim.g.terminal_color_background = colors.bg
vim.g.terminal_color_foreground = colors.text
