-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.font = wezterm.font("Maple Mono NF")
config.font_size = 16.0
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.term = "xterm-256color"
-- config.color_scheme = "catppuccin-macchiato"
config.color_scheme = 'Catppuccin Mocha (Gogh)'
-- config.color_scheme = 'Chalk (dark) (terminal.sexy)'


config.window_background_opacity = 0.8
config.macos_window_background_blur = 18
-- config.default_prog = { "tmux" }

-- and finally, return the configuration to wezterm
return config
