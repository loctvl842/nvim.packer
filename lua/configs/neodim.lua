local status_ok, neodim = pcall(require, "neodim")
if not status_ok then
	return
end

neodim.setup({
	alpha = 0.75,
	blend_color = "#000000",
	update_in_insert = {
		enable = true,
		delay = 100,
	},
	hide = {
		virtual_text = true,
		signs = true,
		underline = true,
	},
})
