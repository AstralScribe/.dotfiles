local setup, comment = pcall(require, "Comment")
if not setup then
  return
end

comment.setup({
  toggler = {
    line = "<C-/>",
  },
  opleader = {
    line = "<C-/>"
  },
})
