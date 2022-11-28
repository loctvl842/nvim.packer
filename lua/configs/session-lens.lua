local status_ok, session_lens = pcall(require, "session-lens")
if not status_ok then
	return
end

session_lens.setup({
	path_display = { "shorten" },
	theme_conf = {
		border = true,
		borderchars = {  "█", " ", "▀", "█", "█", " ", " ", "▀" },
	},
	previewer = false,
})

require("telescope").load_extension("session-lens")

-- ctrl+d to delete session
