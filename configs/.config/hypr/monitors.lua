hl.monitor({
  output = "HDMI-A-3",
  mode = "1920x1080@75",
  position = "2560x200",
  scale = "auto"
})

hl.monitor({
  output = "DP-2",
  mode = "2560x1440@120",
  position = "0x0",
  scale = "auto",
  bitdepth = 10,
  cm = "hdr",
  vrr = 3,
  supports_hdr = 1,
  supports_wide_color = 1,
  sdrbrightness = 3.5,
  sdrsaturation = 1.0,
})

hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = "auto"
})
