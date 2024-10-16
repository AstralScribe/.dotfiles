local pf_status, pf = pcall(require, "pretty-fold")
if not pf_status then
  return
end

vim.opt.foldmethod = 'expr' -- enable folding (default 'foldmarker')
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 9999    -- open a file fully expanded, set to

pf.setup({
  keep_indentation = false,
  fill_char = '━',
  sections = {
    left = {
      '━ ', function() return string.rep('*', vim.v.foldlevel) end, ' ━┫', 'content', '┣'
    },
    right = {
      '┫ ', 'number_of_folded_lines', ': ', 'percentage', ' ┣━━',
    }
  }
})



-- local ufo_status, ufo = pcall(require, "ufo")
-- if not ufo_status then
--   return
-- end
--
--
-- vim.o.foldcolumn = '0' -- '0' is not bad
-- vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
-- vim.o.foldlevelstart = 99
-- vim.o.foldenable = true
--
-- ufo.setup({
--   open_fold_hl_timeout = 150,
--   close_fold_kinds_for_ft = {
--     default = { 'imports', 'comment' },
--     json = { 'array' },
--     c = { 'comment', 'region' }
--   },
--   preview = {
--     win_config = {
--       border = { '', '─', '', '', '', '─', '', '' },
--       winhighlight = 'Normal:Folded',
--       winblend = 0
--     },
--     mappings = {
--       scrollU = '<C-u>',
--       scrollD = '<C-d>',
--       jumpTop = '[',
--       jumpBot = ']'
--     }
--   },
--   provider_selector = function(bufnr, filetype, buftype)
--     return { 'treesitter', 'indent' }
--   end
-- })
--
--
-- vim.keymap.set('n', 'zR', ufo.openAllFolds)
-- vim.keymap.set('n', 'zM', ufo.closeAllFolds)
-- vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
-- vim.keymap.set('n', 'zm', ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
-- vim.keymap.set('n', 'K', function()
--   local winid = ufo.peekFoldedLinesUnderCursor()
--   if not winid then
--     -- choose one of coc.nvim and nvim lsp
--     vim.fn.CocActionAsync('definitionHover') -- coc.nvim
--     vim.lsp.buf.hover()
--   end
-- end)
