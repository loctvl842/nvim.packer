local status_ok, monokai = pcall(require, "monokai-pro")
if not status_ok then
	return
end

monokai.setup({
	transparent_background = true,
	italic_comments = true,
	filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
	inc_search = "underline", -- underline | background
	diagnostic = {
		background = true,
	},
	plugins = {
		bufferline = {
			underline_selected = true,
		},
		toggleterm = {
			background_clear = false,
		},
		telescope = {
			background_clear = false,
		},
		cmp = {
			background_clear = false,
		},
		whichkey = {
			background_clear = false,
		},
		indent_blankline = {
			context_highlight = "pro", -- default | pro
		},
	},
})
