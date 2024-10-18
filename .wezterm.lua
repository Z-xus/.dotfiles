local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("Maple Mono NF")
config.font_size = 16.0
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.term = "xterm-256color"
-- config.color_scheme = "catppuccin-macchiato"
config.color_scheme = "Catppuccin Mocha (Gogh)"
-- config.color_scheme = 'Chalk (dark) (terminal.sexy)'

config.window_background_opacity = 0.8
config.macos_window_background_blur = 12

return config
