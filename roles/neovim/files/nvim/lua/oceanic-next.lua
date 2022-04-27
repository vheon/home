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

vim.api.nvim_set_hl(0, 'Bold', { bold = true })
vim.api.nvim_set_hl(0, 'Debug', { fg = colors.red })
vim.api.nvim_set_hl(0, 'Directory', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'ErrorMsg', { fg = colors.red, bg = colors.base00 })
vim.api.nvim_set_hl(0, 'Exception', { fg = colors.red })
vim.api.nvim_set_hl(0, 'FoldColumn', { fg = colors.blue, bg = colors.base00 })
vim.api.nvim_set_hl(0, 'Folded', { fg = colors.base03, bg = colors.base01, italic = true })
vim.api.nvim_set_hl(0, 'IncSearch', { fg = colors.base01, bg = colors.orange })
vim.api.nvim_set_hl(0, 'Italic', { italic = true })

vim.api.nvim_set_hl(0, 'Macro', { fg = colors.red})
vim.api.nvim_set_hl(0, 'MatchParen', { fg = colors.base05, bg = colors.base03 })
vim.api.nvim_set_hl(0, 'ModeMsg', { fg = colors.green})
vim.api.nvim_set_hl(0, 'MoreMsg', { fg = colors.green})
vim.api.nvim_set_hl(0, 'Question', { fg = colors.blue})
vim.api.nvim_set_hl(0, 'Search', { fg = colors.base03, bg = colors.yellow })
vim.api.nvim_set_hl(0, 'SpecialKey', { fg = colors.base03})
vim.api.nvim_set_hl(0, 'TooLong', { fg = colors.red})
vim.api.nvim_set_hl(0, 'Underlined', { fg = colors.red})
vim.api.nvim_set_hl(0, 'Visual', { bg = colors.base02 })
vim.api.nvim_set_hl(0, 'VisualNOS', { fg = colors.red})
vim.api.nvim_set_hl(0, 'WarningMsg', { fg = colors.red})
vim.api.nvim_set_hl(0, 'WildMenu', { fg = colors.text, bg = colors.blue })
vim.api.nvim_set_hl(0, 'Title', { fg = colors.blue})
vim.api.nvim_set_hl(0, 'Conceal', { fg = colors.blue, bg = colors.base00 })
vim.api.nvim_set_hl(0, 'Cursor', { fg = colors.base00, bg = colors.base05 })
vim.api.nvim_set_hl(0, 'NonText', { fg = colors.base03})
vim.api.nvim_set_hl(0, 'Normal', { fg = colors.text, bg = colors.base00 })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = colors.base05, bg = colors.base00 })
vim.api.nvim_set_hl(0, 'LineNr', { fg = colors.base03, bg = colors.base00 })
vim.api.nvim_set_hl(0, 'SignColumn', { fg = colors.base00, bg = colors.base00 })
vim.api.nvim_set_hl(0, 'StatusLine', { fg = colors.base01, bg = colors.base07 })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = colors.base03, bg = colors.base01 })
vim.api.nvim_set_hl(0, 'VertSplit', { fg = colors.base00, bg = colors.base02 })
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = colors.base01 })
vim.api.nvim_set_hl(0, 'CursorColumn', { bg = colors.base01 })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = colors.base01, fg = colors.none })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = colors.base03, bg = colors.base01 })
vim.api.nvim_set_hl(0, 'PMenu', { fg = colors.base04, bg = colors.base01 })
vim.api.nvim_set_hl(0, 'PMenuSel', { fg = colors.text, bg = colors.blue })
vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = colors.base02 })
vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = colors.base07 })
vim.api.nvim_set_hl(0, 'TabLine', { fg = colors.base03, bg = colors.base01 })
vim.api.nvim_set_hl(0, 'TabLineFill', { fg = colors.base03, bg = colors.base01 })
vim.api.nvim_set_hl(0, 'TabLineSel', { fg = colors.green, bg = colors.base01 })
vim.api.nvim_set_hl(0, 'helpExample', { fg = colors.yellow})
vim.api.nvim_set_hl(0, 'helpCommand', { fg = colors.yellow})

-- Standard syntax highlighting
vim.api.nvim_set_hl(0, 'Boolean', { fg = colors.orange })
vim.api.nvim_set_hl(0, 'Character', { fg = colors.red })
vim.api.nvim_set_hl(0, 'Comment', { fg = colors.base03, italic = true })
vim.api.nvim_set_hl(0, 'Conditional', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'Constant', { fg = colors.orange })
vim.api.nvim_set_hl(0, 'Define', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'Delimiter', { fg = colors.brown })
vim.api.nvim_set_hl(0, 'Float', { fg = colors.orange })
vim.api.nvim_set_hl(0, 'Function', { fg = colors.blue })

vim.api.nvim_set_hl(0, 'Identifier', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'Include', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'Keyword', { fg = colors.purple })

vim.api.nvim_set_hl(0, 'Label', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'Number', { fg = colors.orange })
vim.api.nvim_set_hl(0, 'Operator', { fg = colors.base05 })
vim.api.nvim_set_hl(0, 'PreProc', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'Repeat', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'Special', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'SpecialChar', { fg = colors.brown })
vim.api.nvim_set_hl(0, 'Statement', { fg = colors.red })
vim.api.nvim_set_hl(0, 'StorageClass', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'String', { fg = colors.green })
vim.api.nvim_set_hl(0, 'Structure', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'Tag', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'Todo', { fg = colors.yellow, bg = colors.base01 })
vim.api.nvim_set_hl(0, 'Type', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'Typedef', { fg = colors.yellow })

-- LSP
vim.api.nvim_set_hl(0, 'LspDiagnosticsDefaultError', { })
vim.api.nvim_set_hl(0, 'LspDiagnosticsSignError', { fg = colors.red })
vim.api.nvim_set_hl(0, 'LspDiagnosticsUnderlineError', { undercurl = true })

vim.api.nvim_set_hl(0, 'LspDiagnosticsDefaultWarning', { })
vim.api.nvim_set_hl(0, 'LspDiagnosticsSignWarning', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'LspDiagnosticsUnderlineWarning', { undercurl = true })

vim.api.nvim_set_hl(0, 'LspDiagnosticsDefaultInformation', { })
vim.api.nvim_set_hl(0, 'LspDiagnosticsSignInformation', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'LspDiagnosticsUnderlineInformation', { undercurl = true })

vim.api.nvim_set_hl(0, 'LspDiagnosticsDefaultHint', { })
vim.api.nvim_set_hl(0, 'LspDiagnosticsSignHint', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'LspDiagnosticsUnderlineHint', { undercurl = true })


-- TreeSitter stuff
vim.api.nvim_set_hl(0, 'TSInclude', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'TSPunctBracket', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'TSPunctDelimiter', { fg = colors.text })
vim.api.nvim_set_hl(0, 'TSParameter', { fg = colors.text })
vim.api.nvim_set_hl(0, 'TSType', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'TSFunction', { fg = colors.cyan })

vim.api.nvim_set_hl(0, 'TSTagDelimiter', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'TSProperty', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'TSMethod', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'TSParameter', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'TSConstructor', { fg = colors.text })
vim.api.nvim_set_hl(0, 'TSVariable', { fg = colors.text })
vim.api.nvim_set_hl(0, 'TSOperator', { fg = colors.text })
vim.api.nvim_set_hl(0, 'TSTag', { fg = colors.text })
vim.api.nvim_set_hl(0, 'TSKeyword', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'TSKeywordOperator', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'TSVariableBuiltin', { fg = colors.red })
vim.api.nvim_set_hl(0, 'TSLabel', { fg = colors.cyan })

vim.api.nvim_set_hl(0, 'TSText', { fg = colors.text })    -- For strings considered text in a markup language.
vim.api.nvim_set_hl(0, 'TSTextReference', { fg = colors.yellow }) -- FIXME
vim.api.nvim_set_hl(0, 'TSEmphasis', { fg = '#FF0000' })    -- For text to be represented with emphasis.
vim.api.nvim_set_hl(0, 'TSUnderline', { fg = colors.text, bg = colors.none, underline = true })    -- For text to be represented with an underline.

vim.api.nvim_set_hl(0, 'SpellBad', { undercurl = true })
vim.api.nvim_set_hl(0, 'SpellLocal', { undercurl = true })
vim.api.nvim_set_hl(0, 'SpellCap', { undercurl = true })
vim.api.nvim_set_hl(0, 'SpellRare', { undercurl = true })

vim.api.nvim_set_hl(0, 'csClass', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'csAttribute', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'csModifier', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'csType', { fg = colors.red })
vim.api.nvim_set_hl(0, 'csUnspecifiedStatement', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'csContextualStatement', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'csNewDecleration', { fg = colors.red })
vim.api.nvim_set_hl(0, 'cOperator', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'cPreCondit', { fg = colors.purple })

vim.api.nvim_set_hl(0, 'cssColor', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'cssBraces', { fg = colors.base05 })
vim.api.nvim_set_hl(0, 'cssClassName', { fg = colors.purple })


vim.api.nvim_set_hl(0, 'DiffAdd', { fg = colors.green, bg = colors.base01, bold = true })
vim.api.nvim_set_hl(0, 'DiffChange', { fg = colors.base03, bg = colors.base01 })
vim.api.nvim_set_hl(0, 'DiffDelete', { fg = colors.red, bg = colors.base01 })
vim.api.nvim_set_hl(0, 'DiffText', { fg = colors.blue, bg = colors.base01 })
vim.api.nvim_set_hl(0, 'DiffFile', { fg = colors.red, bg = colors.base00 })
vim.api.nvim_set_hl(0, 'DiffNewFile', { fg = colors.green, bg = colors.base00 })
vim.api.nvim_set_hl(0, 'DiffLine', { fg = colors.blue, bg = colors.base00 })

vim.api.nvim_set_hl(0, 'gitCommitOverflow', { fg = colors.red })
vim.api.nvim_set_hl(0, 'gitCommitSummary', { fg = colors.green })

vim.api.nvim_set_hl(0, 'htmlBold', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'htmlItalic', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'htmlTag', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'htmlEndTag', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'htmlArg', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'htmlTagName', { fg = colors.text })

vim.api.nvim_set_hl(0, 'javaScript', { fg = colors.base05 })
vim.api.nvim_set_hl(0, 'javaScriptNumber', { fg = colors.orange })
vim.api.nvim_set_hl(0, 'javaScriptBraces', { fg = colors.base05 })

vim.api.nvim_set_hl(0, 'jsonKeyword', { fg = colors.green })
vim.api.nvim_set_hl(0, 'jsonQuote', { fg = colors.green })

vim.api.nvim_set_hl(0, 'markdownCode', { fg = colors.green })
vim.api.nvim_set_hl(0, 'markdownCodeBlock', { fg = colors.green })
vim.api.nvim_set_hl(0, 'markdownHeadingDelimiter', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'markdownItalic', { fg = colors.purple, italic = true })
vim.api.nvim_set_hl(0, 'markdownBold', { fg = colors.yellow, bold = true })
vim.api.nvim_set_hl(0, 'markdownCodeDelimiter', { fg = colors.brown, italic = true })
vim.api.nvim_set_hl(0, 'markdownError', { fg = colors.base05, bg = colors.base00 })

vim.api.nvim_set_hl(0, 'typescriptParens', { fg = colors.base05, bg = colors.none })

vim.api.nvim_set_hl(0, 'phpComparison', { fg = colors.base05 })
vim.api.nvim_set_hl(0, 'phpParent', { fg = colors.base05 })
vim.api.nvim_set_hl(0, 'phpMemberSelector', { fg = colors.base05 })

vim.api.nvim_set_hl(0, 'pythonRepeat', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'pythonOperator', { fg = colors.purple })

vim.api.nvim_set_hl(0, 'rubyConstant', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'rubySymbol', { fg = colors.green })
vim.api.nvim_set_hl(0, 'rubyAttribute', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'rubyInterpolation', { fg = colors.green })
vim.api.nvim_set_hl(0, 'rubyInterpolationDelimiter', { fg = colors.brown })
vim.api.nvim_set_hl(0, 'rubyStringDelimiter', { fg = colors.green })
vim.api.nvim_set_hl(0, 'rubyRegexp', { fg = colors.cyan })

vim.api.nvim_set_hl(0, 'vimfilerLeaf', { fg = colors.base05 })
vim.api.nvim_set_hl(0, 'vimfilerNormalFile', { fg = colors.base05, bg = colors.base00 })
vim.api.nvim_set_hl(0, 'vimfilerOpenedFile', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'vimfilerClosedFile', { fg = colors.blue })

vim.api.nvim_set_hl(0, 'GitGutterAdd', { fg = colors.green, bg = colors.base00, bold = true })
vim.api.nvim_set_hl(0, 'GitGutterChange', { fg = colors.blue, bg = colors.base00, bold = true })
vim.api.nvim_set_hl(0, 'GitGutterDelete', { fg = colors.red, bg = colors.base00, bold = true })
vim.api.nvim_set_hl(0, 'GitGutterChangeDelete', { fg = colors.purple, bg = colors.base00, bold = true })

vim.api.nvim_set_hl(0, 'SignifySignAdd', { fg = colors.green, bg = colors.base00, bold = true })
vim.api.nvim_set_hl(0, 'SignifySignChange', { fg = colors.blue, bg = colors.base00, bold = true })
vim.api.nvim_set_hl(0, 'SignifySignDelete', { fg = colors.red, bg = colors.base00, bold = true })
vim.api.nvim_set_hl(0, 'SignifySignChangeDelete', { fg = colors.purple, bg = colors.base00, bold = true })
vim.api.nvim_set_hl(0, 'SignifySignDeleteFirstLine', { fg = colors.red, bg = colors.base00, bold = true })

vim.api.nvim_set_hl(0, 'xmlTag', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'xmlTagName', { fg = colors.base05 })
vim.api.nvim_set_hl(0, 'xmlEndTag', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'Defx_filename_directory', { fg = colors.blue })

vim.api.nvim_set_hl(0, 'User2', { fg = colors.white, bg = colors.base01, bold = true })
vim.api.nvim_set_hl(0, 'User3', { fg = colors.base07, bg = colors.base01, italic = true })
vim.api.nvim_set_hl(0, 'User4', { fg = colors.white, bg = colors.base01 })
vim.api.nvim_set_hl(0, 'User5', { fg = colors.base00, bg = colors.white, bold = true })

vim.api.nvim_set_hl(0, 'SimpleMarkWord1', { fg = colors.bg, bg = colors.cyan })
vim.api.nvim_set_hl(0, 'SimpleMarkWord2', { fg = colors.bg, bg = colors.red })
vim.api.nvim_set_hl(0, 'SimpleMarkWord3', { fg = colors.bg, bg = colors.green })
vim.api.nvim_set_hl(0, 'SimpleMarkWord4', { fg = colors.bg, bg = colors.yellow })
vim.api.nvim_set_hl(0, 'SimpleMarkWord5', { fg = colors.bg, bg = colors.blue })
vim.api.nvim_set_hl(0, 'SimpleMarkWord6', { fg = colors.bg, bg = colors.base05 })

vim.api.nvim_set_hl(0, 'NeogitBranch', { fg = colors.orange })
vim.api.nvim_set_hl(0, 'NeogitRemote', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'NeogitHunkHeader', { fg = colors.fg, bg = colors.red })
vim.api.nvim_set_hl(0, 'NeogitHunkHeaderHighlight', { fg = colors.bg, bg = colors.yellow })
vim.api.nvim_set_hl(0, 'NeogitDiffContextHighlight', { fg = colors.fg, bg = colors.bg })

vim.api.nvim_set_hl(0, 'DiffAdded', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'DiffRemoved', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'NeogitDiffAddHighlight', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'NeogitDiffDeleteHighlight', { link = 'DiffDelete' })

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
