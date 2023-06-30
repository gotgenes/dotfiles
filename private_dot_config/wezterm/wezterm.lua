local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular' })
config.font_size = 12.0
config.line_height = 1.05
config.color_scheme = 'Catppuccin Macchiato'
config.initial_rows = 60
config.initial_cols = 180

return config
