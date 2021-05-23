-- Based on https://github.com/mhartington/oceanic-next

vim.o.background = 'dark'
vim.cmd 'hi clear'

if vim.fn.exists("syntax_on") then
  vim.cmd 'syntax reset'
end

vim.o.termguicolors = true
vim.g.colors_name = "oceanic-next"

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

local function define_highlight(group, spec)
  if type(spec) == 'string' then
      vim.cmd(table.concat({ 'hi', tostring(group), 'guifg='..spec }, ' '))
  else
    if vim.tbl_isempty(spec) then
      return
    end
    local fg = spec[1]
    local fg = fg and 'guifg='..fg or ''
    local bg = spec.bg and 'guibg='..spec.bg or ''
    local gui = spec.gui and 'gui='..spec.gui or ''
    local attrsp = spec.attrsp and 'guisp='..spec.attrsp or ''
    vim.cmd(table.concat({ 'hi', tostring(group), fg, bg, gui, attrsp }, ' '))
  end
end

local function define_highlights(groups)
  for group, spec in pairs(groups) do
    define_highlight(group, spec)
  end
end

define_highlights {
  Bold = { gui = bold },
  Debug = colors.red,
  Directory = colors.blue,
  ErrorMsg = { colors.red, bg = colors.base00 },
  Exception = colors.red,
  FoldColumn = { colors.blue, bg = colors.base00 },
  Folded = { colors.base03, bg = colors.base01, gui = italic },
  IncSearch = { colors.base01, bg = colors.orange, gui = 'NONE' },
  Italic = { gui = italic },

  Macro = colors.red,
  MatchParen = { colors.base05, bg = colors.base03 },
  ModeMsg = colors.green,
  MoreMsg = colors.green,
  Question = colors.blue,
  Search = { colors.base03, bg = colors.yellow },
  SpecialKey = colors.base03,
  TooLong = colors.red,
  Underlined = colors.red,
  Visual = { bg = colors.base02 },
  VisualNOS = colors.red,
  WarningMsg = colors.red,
  WildMenu = { colors.text, bg = colors.blue },
  Title = colors.blue,
  Conceal = { colors.blue, bg = colors.base00 },
  Cursor = { colors.base00, bg = colors.base05 },
  NonText = colors.base03,
  Normal = { colors.text, bg = colors.base00 },
  EndOfBuffer = { colors.base05, bg = colors.base00 },
  LineNr = { colors.base03, bg = colors.base00 },
  SignColumn = { colors.base00, bg = colors.base00 },
  StatusLine = { colors.base01, bg = colors.base07 },
  StatusLineNC = { colors.base03, bg = colors.base01 },
  VertSplit = { colors.base00, bg = colors.base02 },
  ColorColumn = { bg = colors.base01 },
  CursorColumn = { bg = colors.base01 },
  CursorLine = { bg = colors.base01, gui = 'None' },
  CursorLineNR = { colors.base00, bg = colors.base00 },
  CursorLineNr = { colors.base03, bg = colors.base01 },
  PMenu = { colors.base04, bg = colors.base01 },
  PMenuSel = { colors.text, bg = colors.blue },
  PmenuSbar = { bg = colors.base02 },
  PmenuThumb = { bg = colors.base07 },
  TabLine = { colors.base03, bg = colors.base01 },
  TabLineFill = { colors.base03, bg = colors.base01 },
  TabLineSel = { colors.green, bg = colors.base01 },
  helpExample = colors.yellow,
  helpCommand = colors.yellow,

  -- Standard syntax highlighting
  Boolean = colors.orange,
  Character = colors.red,
  Comment = { colors.base03, gui = italic },
  Conditional = colors.purple,
  Constant = colors.orange,
  Define = colors.purple,
  Delimiter = colors.brown,
  Float = colors.orange,
  Function = colors.blue,

  Identifier = colors.cyan,
  Include = colors.blue,
  Keyword = colors.purple,

  Label = colors.yellow,
  Number = colors.orange,
  Operator = colors.base05,
  PreProc = colors.yellow,
  Repeat = colors.yellow,
  Special = colors.cyan,
  SpecialChar = colors.brown,
  Statement = colors.red,
  StorageClass = colors.yellow,
  String = colors.green,
  Structure = colors.purple,
  Tag = colors.yellow,
  Todo = { colors.yellow, bg = colors.base01 },
  Type = colors.yellow,
  Typedef = colors.yellow,

  -- LSP
  LspDiagnosticsDefaultError = { },
  LspDiagnosticsSignError = colors.red,
  LspDiagnosticsUnderlineError = { gui = 'undercurl' },

  LspDiagnosticsDefaultWarning = { },
  LspDiagnosticsSignWarning = colors.yellow,
  LspDiagnosticsUnderlineWarning = { gui = 'undercurl' },

  LspDiagnosticsDefaultInformation = { },
  LspDiagnosticsSignInformation = colors.blue,
  LspDiagnosticsUnderlineInformation = { gui = 'undercurl' },

  LspDiagnosticsDefaultHint = { },
  LspDiagnosticsSignHint = colors.cyan,
  LspDiagnosticsUnderlineHint = { gui = 'undercurl' },


  -- TreeSitter stuff
  TSInclude = colors.cyan,
  TSPunctBracket = colors.cyan,
  TSPunctDelimiter = colors.text,
  TSParameter = colors.text,
  TSType = colors.blue,
  TSFunction = colors.cyan,

  TSTagDelimiter = colors.cyan,
  TSProperty = colors.yellow,
  TSMethod = colors.blue,
  TSParameter = colors.yellow,
  TSConstructor = colors.text,
  TSVariable = colors.text,
  TSOperator = colors.text,
  TSTag = colors.text,
  TSKeyword = colors.purple,
  TSKeywordOperator = colors.purple,
  TSVariableBuiltin = colors.red,
  TSLabel = colors.cyan,

  TSText = colors.text,    -- For strings considered text in a markup language.
  TSTextReference = colors.yellow, -- FIXME
  TSEmphasis = { '#FF0000' },    -- For text to be represented with emphasis.
  TSUnderline = { colors.text, bg = colors.none, style = 'underline' },    -- For text to be represented with an underline.

  SpellBad = { gui = 'undercurl' },
  SpellLocal = { gui = 'undercurl' },
  SpellCap = { gui = 'undercurl' },
  SpellRare = { gui = 'undercurl' },

  csClass = colors.yellow,
  csAttribute = colors.yellow,
  csModifier = colors.purple,
  csType = colors.red,
  csUnspecifiedStatement = colors.blue,
  csContextualStatement = colors.purple,
  csNewDecleration = colors.red,
  cOperator = colors.cyan,
  cPreCondit = colors.purple,

  cssColor = colors.cyan,
  cssBraces = colors.base05,
  cssClassName = colors.purple,


  DiffAdd = { colors.green, bg = colors.base01, gui = bold },
  DiffChange = { colors.base03, bg = colors.base01 },
  DiffDelete = { colors.red, bg = colors.base01 },
  DiffText = { colors.blue, bg = colors.base01 },
  DiffAdded = { colors.green, bg = colors.base01, gui = bold },
  DiffFile = { colors.red, bg = colors.base00 },
  DiffNewFile = { colors.green, bg = colors.base00 },
  DiffLine = { colors.blue, bg = colors.base00 },
  DiffRemoved = { colors.red, bg = colors.base01, gui = bold },

  gitCommitOverflow = colors.red,
  gitCommitSummary = colors.green,

  htmlBold = colors.yellow,
  htmlItalic = colors.purple,
  htmlTag = colors.cyan,
  htmlEndTag = colors.cyan,
  htmlArg = colors.yellow,
  htmlTagName = colors.text,

  javaScript = colors.base05,
  javaScriptNumber = colors.orange,
  javaScriptBraces = colors.base05,

  jsonKeyword = colors.green,
  jsonQuote = colors.green,

  markdownCode = colors.green,
  markdownCodeBlock = colors.green,
  markdownHeadingDelimiter = colors.blue,
  markdownItalic = { colors.purple, gui = italic },
  markdownBold = { colors.yellow, gui = bold },
  markdownCodeDelimiter = { colors.brown, gui = italic },
  markdownError = { colors.base05, bg = colors.base00 },

  typescriptParens = { colors.base05, bg = colors.none },

  -- NeomakeErrorSign = { colors.red, bg = colors.base00 },
  -- NeomakeWarningSign = { colors.yellow, bg = colors.base00 },
  -- NeomakeInfoSign = { colors.white, bg = colors.base00 },
  -- NeomakeError = { colors.red, gui = 'underline', attrsp = colors.red },
  -- NeomakeWarning = { colors.red, gui = 'underline', attrsp = colors.red },

  -- ALEErrorSign = { colors.red, bg = colors.base00, gui = bold },
  -- ALEWarningSign = { colors.yellow, bg = colors.base00, gui = bold },
  -- ALEInfoSign = { colors.white, bg = colors.base00, gui = bold },

  -- NERDTreeExecFile = colors.base05,
  -- NERDTreeDirSlash = colors.blue,
  -- NERDTreeOpenable = colors.blue,
  -- NERDTreeFile = { bg = colors.none },
  -- NERDTreeFlags = colors.blue,

  phpComparison = colors.base05,
  phpParent = colors.base05,
  phpMemberSelector = colors.base05,

  pythonRepeat = colors.purple,
  pythonOperator = colors.purple,

  rubyConstant = colors.yellow,
  rubySymbol = colors.green,
  rubyAttribute = colors.blue,
  rubyInterpolation = colors.green,
  rubyInterpolationDelimiter = colors.brown,
  rubyStringDelimiter = colors.green,
  rubyRegexp = colors.cyan,

  -- sassidChar = colors.red,
  -- sassClassChar = colors.orange,
  -- sassInclude = colors.purple,
  -- sassMixing = colors.purple,
  -- sassMixinName = colors.blue,

  vimfilerLeaf = colors.base05,
  vimfilerNormalFile = { colors.base05, bg = colors.base00 },
  vimfilerOpenedFile = colors.blue,
  vimfilerClosedFile = colors.blue,

  GitGutterAdd = { colors.green, bg = colors.base00, gui = bold },
  GitGutterChange = { colors.blue, bg = colors.base00, gui = bold },
  GitGutterDelete = { colors.red, bg = colors.base00, gui = bold },
  GitGutterChangeDelete = { colors.purple, bg = colors.base00, gui = bold },

  SignifySignAdd = { colors.green, bg = colors.base00, gui = bold },
  SignifySignChange = { colors.blue, bg = colors.base00, gui = bold },
  SignifySignDelete = { colors.red, bg = colors.base00, gui = bold },
  SignifySignChangeDelete = { colors.purple, bg = colors.base00, gui = bold },
  SignifySignDeleteFirstLine = { colors.red, bg = colors.base00, gui = bold },

  xmlTag = colors.cyan,
  xmlTagName = colors.base05,
  xmlEndTag = colors.cyan,
  Defx_filename_directory = colors.blue,

  -- CocErrorSign = colors.red,
  -- CocWarningSign = colors.yellow,
  -- CocInfoSign = colors.blue,
  -- CocHintSign = colors.cyan,
  -- CocErrorFloat = colors.red,
  -- CocWarningFloat = colors.yellow,
  -- CocInfoFloat = colors.blue,
  -- CocHintFloat = colors.cyan,
  -- CocDiagnosticsError = colors.red,
  -- CocDiagnosticsWarning = colors.yellow,
  -- CocDiagnosticsInfo = colors.blue,
  -- CocDiagnosticsHint = colors.cyan,
  -- CocSelectedText = colors.purple,
  -- CocCodeLens = colors.base04

    User2 = { colors.white, bg = colors.base01, gui = bold },
    User3 = { colors.base07, bg = colors.base01, gui = italic },
    User4 = { colors.white, bg = colors.base01 },
    User5 = { colors.base00, bg = colors.white, gui = bold },

  SimpleMarkWord1 = { colors.bg, bg = colors.cyan },
  SimpleMarkWord2 = { colors.bg, bg = colors.red },
  SimpleMarkWord3 = { colors.bg, bg = colors.green },
  SimpleMarkWord4 = { colors.bg, bg = colors.yellow },
  SimpleMarkWord5 = { colors.bg, bg = colors.blue },
  SimpleMarkWord6 = { colors.bg, bg = colors.base05 }
}

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
