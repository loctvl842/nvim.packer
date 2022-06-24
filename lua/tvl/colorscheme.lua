-- Tokonight config
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_comments = true
vim.g.italic_comments = true

-- vim.g.background = "dark"
vim.cmd([[
  try
    " darkplus
    " palenight
    " tokyonight
    " gruvbox
    colorscheme vscode
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
  endtry
]])
