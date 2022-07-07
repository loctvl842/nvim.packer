-- vim.g.background = "dark"
vim.cmd([[
  try
    colorscheme monokai-plus
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
  endtry
]])
