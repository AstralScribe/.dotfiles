local wezterm = require('wezterm')

local font = "JetBrainsMono Nerd Font Mono"
local font_rules = {
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font {
      family = 'VictorMono',
      weight = 'Bold',
      style = 'Italic',
    },
  },
  {
    italic = true,
    intensity = 'Half',
    font = wezterm.font {
      family = 'VictorMono',
      weight = 'DemiBold',
      style = 'Italic',
    },
  },
  {
    italic = true,
    intensity = 'Normal',
    font = wezterm.font {
      family = 'VictorMono',
      style = 'Italic',
    },
  },
}

return {
  font = wezterm.font { family = font, weight = "Light" },
  font_rules = font_rules

}
