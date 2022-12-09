local status_ok, scrollbar = pcall(require, "scrollbar")
if not status_ok then
	return
end

scrollbar.setup({
	set_highlights = false,
	handlers = {
		cursor = true,
		diagnostic = true,
		gitsigns = true, -- Requires gitsigns
		handle = true,
		search = false, -- Requires hlslens
	},
})
