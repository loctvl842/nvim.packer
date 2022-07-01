-- vim.g.background = "dark"
vim.cmd([[
  try
    colorscheme tokyo-night
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
  endtry
]])
