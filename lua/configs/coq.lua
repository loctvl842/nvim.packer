vim.g.coq_settings = {
  auto_start = true,
	keymap = {
    pre_select = true,
		recommended = false,
	},
}
vim.cmd([[
        ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
        ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
        ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
        ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
        ino <silent><expr> <Tab>   pumvisible() ? "\<C-J>" : "\<Tab>"
        ino <silent><expr> <S-Tab> pumvisible() ? "\<C-K>" : "\<BS>"
      ]])
