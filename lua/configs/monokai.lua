local status_ok, monokai = pcall(require, "monokai-pro")
if not status_ok then
	return
end

monokai.setup({
	transparent_background = false,
	italic_comments = true,
  theme = "pro" -- classic | octagon | pro | machine | ristretto | spectrum
})
-- os.execute('dunstify ' .. 'loc')
