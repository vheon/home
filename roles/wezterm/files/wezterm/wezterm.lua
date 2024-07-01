local wezterm = require 'wezterm'

--[[
-- calculation for dpi on mac by the screens that I usually have available
-- the DPI are calculated following this https://github.com/wez/wezterm/issues/4096#issuecomment-1667003402
-- which seems to work well enough.
--]]
local function adjusted_ppi(ppi)
    return (72 * ppi) / 96
end

local config = wezterm.config_builder()

config.font = wezterm.font( 'SF Mono', { weight = 'Regular' } )
config.font_size = 13
config.line_height = 1.1
config.color_scheme = 'Catppuccin Mocha'
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
    left = '0.5cell',
    right = '0.5cell',
    top = 3,
    bottom = 0,
}
config.dpi_by_screen = {
    ["PHL 275E1"] = adjusted_ppi(108.79),
}
config.front_end = "WebGpu"
config.freetype_load_flags = 'NO_HINTING'
config.freetype_load_target = 'Light'
config.use_ime = false

return config
