local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

-- [M.sep_names.slant] = { "", "" },
local hl_str = function(str, hl_cur, hl_after)
	if hl_after == nil then
		return "%#" .. hl_cur .. "#" .. str .. "%*"
	end
	return "%#" .. hl_cur .. "#" .. str .. "%*" .. "%#" .. hl_after .. "#"
end

local padding_pad = {
	function()
		return hl_str(" ", "SLPadding")
	end,
	padding = 0,
}
local left_bottom_slant_sep = {
	function()
		return hl_str(" ", "SLSeparator")
	end,
	padding = 0,
}
local right_bottom_slant_sep = {
	function()
		return hl_str(" ", "SLSeparator")
	end,
	padding = 0,
}
local left_top_slant_sep = {
	function()
		return hl_str(" ", "SLSeparator")
	end,
	padding = 0,
}
local right_top_slant_sep = {
	function()
		return hl_str(" ", "SLSeparator")
	end,
	padding = 0,
}
local left_slant_sep_alt = {
	function()
		return hl_str("", "SLSeparator", "SLSeparator")
	end,
	padding = 0,
}
local right_slant_sep_alt = {
	function()
		return hl_str("", "SLSeparator", "SLSeparator")
	end,
	padding = 0,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = hl_str("", "SLGitIcon", "SLBranchName"),
	colored = false,
	fmt = function(str)
		if str == "" or str == nil then
			return "!=vcs"
		end

		return str
	end,
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = {
		error = "%#SLError#" .. "  " .. "%*" .. "%#SLError#",
		warn = "%#SLWarning#" .. "  " .. "%*" .. "%#SLWarning#",
	},
	colored = false,
	update_in_insert = false,
	always_visible = true,
	padding = 0,
}

local position = function()
	local current_line = vim.fn.line(".")
	local current_column = vim.fn.col(".")
	local str = "Ln " .. current_line .. ", Col " .. current_column
	return hl_str(str, "SLPosition") .. "%#SLPosition#"
end

local spaces = function()
	local str = "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
	return hl_str(str, "SLShiftWidth", "SLShiftWidth")
end

local encoding = function()
	local str = string.upper(vim.o.fileencoding)
	return hl_str(str, "SLEncoding", "SLEncoding")
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local prev_filetype = ""

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
}

local mode = {
	"mode",
	fmt = function(str)
		local mode_str = " " .. str
		return hl_str(mode_str, "SLMode", "SLMode")
	end,
}

local filetype = {
	"filetype",
	fmt = function(str)
		local ui_filetypes = {
			"help",
			"packer",
			"neogitstatus",
			"NvimTree",
			"Trouble",
			"lir",
			"Outline",
			"spectre_panel",
			"toggleterm",
			"DressingSelect",
			"neo-tree",
			"",
		}
		local filetype_str = ""

		if str == "toggleterm" then
			-- 
			filetype_str = " " .. vim.api.nvim_buf_get_var(0, "toggle_number")
		elseif str == "TelescopePrompt" then
			filetype_str = ""
		elseif str == "neo-tree" then
			filetype_str = prev_filetype
		elseif vim.tbl_contains(ui_filetypes, str) then
			filetype_str = ""
		else
			prev_filetype = str
			filetype_str = str
		end
		return hl_str(filetype_str, "SLFiletype", "SLFiletype")
	end,
	icons_enabled = true,
}
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
	sections = {
		lualine_a = { left_bottom_slant_sep, branch, left_top_slant_sep },
		lualine_b = { padding_pad, left_slant_sep_alt, diagnostics, padding_pad, left_slant_sep_alt },
		lualine_c = { left_bottom_slant_sep },
		lualine_x = {
			right_bottom_slant_sep,
			right_slant_sep_alt,
			padding_pad,
			mode,
			right_slant_sep_alt,
			padding_pad,
		},
		lualine_y = {
			right_top_slant_sep,
			position,
			right_bottom_slant_sep,
			right_top_slant_sep,
			filetype,
			right_bottom_slant_sep,
		},
		lualine_z = {
			right_top_slant_sep,
			spaces,
			right_bottom_slant_sep,
			right_top_slant_sep,
			encoding,
			right_bottom_slant_sep,
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
