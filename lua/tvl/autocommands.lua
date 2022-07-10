vim.cmd([[
  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup remember_folds
		autocmd!
		autocmd BufWinLeave ?* mkview 1
		autocmd BufWinEnter ?* silent! loadview 1
  augroup end
]])

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
	pattern = { "AlphaReady" },
	callback = function()
		vim.cmd([[
      setlocal showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      setlocal laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]])
	end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- fix comment
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.cmd([[
			set formatoptions-=cro
		]])
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		require("neodim").setup({
			alpha = 0.5,
			blend_color = "#333333",
			update_in_insert = {
				enable = false,
				delay = 100,
			},
			hide = {
				virtual_text = true,
				signs = true,
				underline = true,
			},
		})
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "term://*" },
	callback = function()
		vim.cmd("startinsert!")
		-- TODO: if java = 2
		vim.cmd("set cmdheight=0")
	end,
})

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end

-- vim.cmd([[setlocal guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20]])
