local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

-- cool function for progress
-- local progress = function()
-- 	local current_line = vim.fn.line(".")
-- 	local total_lines = vim.fn.line("$")
-- 	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
-- 	local line_ratio = current_line / total_lines
-- 	local index = math.ceil(line_ratio * #chars)
-- 	return chars[index]
-- end

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "auto", -- set them 'darkplus' to get lualine like vscode
		component_separators = { left = "", right = "" },
		-- section_separators = { left = "", right = "" },
		-- component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha" },
		always_divide_middle = true,
	},
	tabline = {},
	extensions = {},
})
