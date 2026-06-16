hl.config({
  animations = {
    enabled = true,
  }
})

--------------------------------------------------------------------------------
-- Animation Curves (Bezier)
--------------------------------------------------------------------------------
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("md3_standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("md3_accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })
hl.curve("crazyshot", { type = "bezier", points = { { 0.1, 1.5 }, { 0.76, 0.92 } } })
hl.curve("hyprnostretch", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } })
hl.curve("fluent_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("easeInOutCirc", { type = "bezier", points = { { 0.85, 0 }, { 0.15, 1 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.55 }, { 0.45, 1 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })

--------------------------------------------------------------------------------
-- Animation Rules
--------------------------------------------------------------------------------
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 2.5, bezier = "md3_decel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.5, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "md3_decel", style = "slidevert" })


-- --------------------------------------------------------------------------------
-- -- Animation Curves (Bezier)
-- --------------------------------------------------------------------------------
-- hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
-- hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
-- hl.curve("easeOutBack", { type = "bezier", points = { { 0.34, 1.56 }, { 0.64, 1 } } })
-- hl.curve("easeInBack", { type = "bezier", points = { { 0.36, 0 }, { 0.66, -0.56 } } })
-- hl.curve("easeInOutBack", { type = "bezier", points = { { 0.68, -0.6 }, { 0.32, 1.6 } } })
--
-- --------------------------------------------------------------------------------
-- -- Animation Rules
-- --------------------------------------------------------------------------------
-- hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "overshot", style = "slide" })
-- hl.animation({ leaf = "windowsOut", enabled = true, speed = 100, bezier = "easeOutExpo" })
-- hl.animation({ leaf = "windowsIn", enabled = true, speed = 7, bezier = "easeOutBack" })
-- hl.animation({ leaf = "windowsMove", enabled = true, speed = 6, bezier = "easeInOutBack", style = "slide" })
-- hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "default" })
-- hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "easeOutBack" })
-- hl.animation({ leaf = "fadeDim", enabled = true, speed = 5, bezier = "easeOutBack" })
-- hl.animation({ leaf = "workspaces", enabled = true, speed = 10, bezier = "easeOutExpo" })



-- --------------------------------------------------------------------------------
-- -- Animation Curves (Bezier)
-- --------------------------------------------------------------------------------
-- hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
-- hl.curve("smoothOut", { type = "bezier", points = { { 0.5, 0 }, { 0.99, 0.99 } } })
-- hl.curve("smoothIn", { type = "bezier", points = { { 0.5, -0.5 }, { 0.68, 1.5 } } })
--
-- --------------------------------------------------------------------------------
-- -- Animation Rules
-- --------------------------------------------------------------------------------
-- hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "overshot", style = "slide" })
-- hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "smoothOut" })
-- hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "smoothOut" })
-- hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "smoothIn", style = "slide" })
-- hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "default" })
-- hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "smoothIn" })
-- hl.animation({ leaf = "fadeDim", enabled = true, speed = 5, bezier = "smoothIn" })
-- hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })
