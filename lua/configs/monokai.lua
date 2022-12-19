local status_ok, monokai = pcall(require, "monokai-pro")
if not status_ok then
	return
end

monokai.setup({
	transparent_background = true,
	italic_comments = true,
	filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
	diagnostic = {
		background = false,
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
    }
	},
})
