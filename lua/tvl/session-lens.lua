local status_ok, session_lens = pcall(require, "session-lens")
if not status_ok then
	return
end

session_lens.setup({
	path_display = { "shorten" },
	theme_conf = { border = true },
	previewer = false,
})

-- ctrl+d to delete session
