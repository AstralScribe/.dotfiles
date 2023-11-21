local setup, truezen = pcall(require, "true-zen")
if not setup then
    return
end

truezen.setup({
  modes = {
    ataraxis = {
      shade = "dark",
      backdrop = 0,
      minimum_writing_area = {
        width = 70,
        height = 44,
      },
      quit_untoggles = true,
      padding = {
        left = 52,
        right = 52,
        top = 0,
        bottom = 0,
      },
    },
    minimalist = {
      ignored_buf_types = { "nofile" },
      options = {
        number = false,
        relativenumber = false,
        showtabline = 0,
        signcolumn = "no",
        statusline = "",
        cmdheight = 1,
        laststatus = 0,
        showcmd = false,
        showmode = false,
        ruler = false,
        numberwidth = 1
      },
    },
    narrow = {
      folds_style = "informative",
      run_ataraxis = true,
    },
    focus = {}
  },
  integrations = {
    tmux = true,
    twilight = true,
    lualine = true
  },
})
