local perfanno = require("perfanno")
-- local util = require("perfanno.util")
--
-- local bgcolor = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg", "gui")

perfanno.setup {
  -- Creates a 10-step RGB color gradient beween bgcolor and "#CC3300"
  line_highlights = nil,
  vt_highlight = nil
}
