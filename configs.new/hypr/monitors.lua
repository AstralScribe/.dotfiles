hl.monitor({
  output = "DP-2",
  mode = "2560x1440@120",
  position = "0x0",
  scale = "auto",
  bitdepth = 10,
  cm = "hdr",
  vrr = 3,
  sdrbrightness = 1.4,
  sdrsaturation = 0.98,
  supports_wide_color = true,
  supports_hdr = true,
  sdr_min_luminance = 0.005,
  sdr_max_luminance = 200,
  min_luminance = 0,
  max_luminance = 570,
  max_avg_luminance = 275
})

hl.monitor({
  output = "HDMI-A-3",
  mode = "1920x1080@75",
  position = "auto-right",
  scale = "auto"
})
