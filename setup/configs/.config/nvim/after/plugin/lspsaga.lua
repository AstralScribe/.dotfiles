local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
  return
end

saga.setup({
  lightbulb = {
    enable = false,
    virtual_text = false
  }
})
