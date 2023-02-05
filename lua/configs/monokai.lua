local status_ok, monokai = pcall(require, "monokai-pro")
if not status_ok then
	return
end

monokai.setup({
	transparent_background = false,
	italic_comments = true,
	filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
	inc_search = "underline", -- underline | background
	background_clear = {},
	diagnostic = {
		background = true,
	},
	plugins = {
		bufferline = {
			underline_selected = true,
		},
		indent_blankline = {
			context_highlight = "pro", -- default | pro
		},
	},
})

vim.cmd([[colorscheme monokai-pro]])
