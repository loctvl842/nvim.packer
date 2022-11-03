vim.cmd([[
  augroup remember_folds
		autocmd!
		autocmd BufWinLeave ?* silent! mkview 1
		autocmd BufWinEnter ?* silent! loadview 1
  augroup end
]])

vim.cmd([[
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedCurWord cterm=italic gui=italic
augroup END
]])

-- fix tab in python
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.cpp" },
	callback = function()
		vim.cmd("setlocal noexpandtab")
	end,
})

-- fix cmdheight in file java
vim.api.nvim_create_autocmd({ "BufEnter"}, {
  pattern = { "*.java"},
  callback = function ()
    vim.opt.cmdheight = 1
  end
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q! :close<CR> 
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
		vim.cmd([[set formatoptions-=cro]])
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
	pattern = { "" },
	callback = function()
		local get_project_dir = function()
			local cwd = vim.fn.getcwd()
			local project_dir = vim.split(cwd, "/")
			local project_name = project_dir[#project_dir]
			return project_name
		end

		vim.opt.titlestring = get_project_dir()
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "term://*" },
	callback = function()
		vim.cmd("startinsert!")
		vim.cmd("set cmdheight=1")
	end,
})


vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		local status_ok, luasnip = pcall(require, "luasnip")
		if not status_ok then
			return
		end
		if luasnip.expand_or_jumpable() then
			-- ask maintainer for option to make this silent
			-- luasnip.unlink_current()
			vim.cmd([[silent! lua require("luasnip").unlink_current()]])
		end
	end,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
	callback = function()
		vim.cmd([[silent! NeoTreeClose]])
	end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		vim.cmd([[echon '']])
	end,
})

-- vim.api.nvim_create_autocmd({ "VimResized" }, {
--   callback = function()
--     vim.cmd "tabdo wincmd ="
--   end,
-- })

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end

-- vim.cmd([[setlocal guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20]])
