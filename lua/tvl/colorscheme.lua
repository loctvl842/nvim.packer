-- vim.g.background = "dark"
vim.cmd([[
  try
    colorscheme monokai
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
  endtry
]])
