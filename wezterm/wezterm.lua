local setup, wezterm = pcall(require, "wezterm")
if not setup then
  return
end

if wezterm.config_builder then
  Config = wezterm.config_builder()
end

Config.color_scheme = "Github Dark"

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


return Config
