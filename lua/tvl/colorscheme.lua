-- Tokonight config
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_comments = true
vim.g.italic_comments = true

vim.g.tokyodark_enable_italic_comment = true

vim.g.background = "dark"
vim.cmd([[
  try
    " darkplus
    " palenight
    " tokyonight
    " gruvbox
    colorscheme tokyonight
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
  endtry
]])
