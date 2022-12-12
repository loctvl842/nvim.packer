local status_ok, monokai = pcall(require, "monokai-pro")
if not status_ok then
	return
end

monokai.setup({
	transparent_background = false,
	italic_comments = true,
	filter = "classic", -- classic | octagon | pro | machine | ristretto | spectrum
	diagnostic = {
		background = false,
	},
	plugins = {
		bufferline = {
			underline_selected = true,
		},
    toggleterm = {
      background_cleared = true,
    }
	},
})
