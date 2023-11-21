local setup, wezterm = pcall(require, "wezterm")
if not setup then
  return
end

if wezterm.config_builder then
  Config = wezterm.config_builder()
end

Config.color_scheme = "Github Dark"
-- Config.color_scheme = "Catppuccin Mocha"

-- Config.font = wezterm.font { family = 'JetBrainsMono Nerd Font Mono', weight = "Light" }
Config.font = wezterm.font { family = 'Fira Code', weight = "Light" }
Config.font_rules = {
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font {
      family = 'VictorMono Nerd Font',
      weight = 'Bold',
      style = 'Italic',
    },
  },
  {
    italic = true,
    intensity = 'Half',
    font = wezterm.font {
      family = 'VictorMono Nerd Font',
      weight = 'DemiBold',
      style = 'Italic',
    },
  },
  {
    italic = true,
    intensity = 'Normal',
    font = wezterm.font {
      family = 'VictorMono Nerd Font',
      style = 'Italic',
    },
  },
}

Config.hide_tab_bar_if_only_one_tab = true

-- The art is a bit too bright and colorful to be useful as a backdrop
-- for text, so we're going to dim it down to 10% of its normal brightness
local dimmer = { brightness = 0.05 }

-- Config.enable_scroll_bar = true
Config.min_scroll_bar_height = '2cell'
Config.colors = {
  scrollbar_thumb = 'white',
}
Config.background = {
  -- This is the deepest/back-most layer. It will be rendered first
  {
    source = {
      File = '/home/mayank/Pictures/wezterm-bg1.jpg',
    },
    -- The texture tiles vertically but not horizontally.
    -- When we repeat it, mirror it so that it appears "more seamless".
    -- An alternative to this is to set `width = "100%"` and have
    -- it stretch across the display
    repeat_x = 'Mirror',
    hsb = dimmer,
    -- When the viewport scrolls, move this layer 10% of the number of
    -- pixels moved by the main viewport. This makes it appear to be
    -- further behind the text.
    attachment = { Parallax = 0.1 },
  },
}

Config.window_decorations = "NONE"


Config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}

return Config
