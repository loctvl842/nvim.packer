local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local separator = "bubble" -- bubble | triangle
local separator_icon = {
	left = "",
	right = "",
}

local alt_separator_icon = {
	left = "",
	right = "",
}

if separator == "triangle" then
	separator_icon = {
		left = "",
		right = "",
	}

	alt_separator_icon = {
		left = "",
		right = "",
	}
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 150
end

-- tvl
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

local branch = {
	"branch",
	icons_enabled = false,
	icon = hl_str("", "SLGitIcon", "SLBranchName"),
	colored = false,
	fmt = function(str)
		local icon = hl_str(" ", "SLGitIcon", "SLBranchName")
		if str == "" or str == nil then
			return "!=vcs"
		end
		return hl_str(separator_icon.left, "SLSeparator")
			.. hl_str(" " .. icon, "SLGitIcon")
			.. hl_str(str .. " ", "SLBranchName")
			.. hl_str(separator_icon.right, "SLSeparator", "SLSeparator")
	end,
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info" },
	symbols = {
		error = "%#SLError#" .. "  " .. "%*" .. "%#SLError#",
		warn = "%#SLWarning#" .. "  " .. "%*" .. "%#SLWarning#",
		info = "%#SLInfo#" .. "  " .. "%*" .. "%#SLInfo#",
	},
	colored = false,
	update_in_insert = false,
	always_visible = true,
	padding = 0,
	on_click = function()
		vim.diagnostic.goto_next({ buffer = 0 })
	end,
	fmt = function(str)
		return hl_str(alt_separator_icon.left, "SLSeparator")
			.. str
			.. " "
			.. hl_str(alt_separator_icon.right, "SLSeparator")
	end,
}

local position = function()
	local current_line = vim.fn.line(".")
	local current_column = vim.fn.col(".")
	local left_sep = hl_str(separator_icon.left, "SLSeparator")
	local right_sep = hl_str(separator_icon.right, "SLSeparator", "SLSeparator")
	local str = " Ln " .. current_line .. ", Col " .. current_column .. " "
	return left_sep .. hl_str(str, "SLPosition", "SLPosition") .. right_sep
end

local spaces = function()
	local left_sep = hl_str(separator_icon.left, "SLSeparator")
	local right_sep = hl_str(separator_icon.right, "SLSeparator", "SLSeparator")
	local str = "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
	return left_sep .. hl_str(" " .. str .. " ", "SLShiftWidth", "SLShiftWidth") .. right_sep
end

local encoding = function()
	local str = string.upper(vim.o.fileencoding)
	return hl_str(str, "SLEncoding", "SLEncoding")
end

local diff = {
	"diff",
	colored = true,
	diff_color = {
		added = "SLDiffAdd",
		modified = "SLDiffChange",
		removed = "SLDiffDelete",
	},
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	fmt = function(str)
		if str == "" then
			return ""
		end
		local left_sep = hl_str(alt_separator_icon.left .. " ", "SLSeparator")
		local right_sep = hl_str(" " .. alt_separator_icon.right, "SLSeparator", "SLSeparator")
		return left_sep .. str .. right_sep
	end,
}

local mode = {
	"mode",
	fmt = function(str)
		local left_sep = hl_str(separator_icon.left, "SLSeparator", "SLPadding")
		local right_sep = hl_str(separator_icon.right, "SLSeparator", "SLPadding")
		return left_sep .. hl_str(" " .. str .. " ", "SLMode") .. right_sep
	end,
}

local prev_filetype = ""

local filetype = {
	"filetype",
	icons_enabled = false,
	icons_only = false,
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
		elseif str == "neo-tree" or str == "neo-tree-popup" then
			filetype_str = prev_filetype
		elseif str == "help" then
			filetype_str = ""
		elseif vim.tbl_contains(ui_filetypes, str) then
			filetype_str = ""
    elseif str == "" then
      return ""
		else
			prev_filetype = str
			filetype_str = str
		end
		local left_sep = hl_str(separator_icon.left, "SLSeparator")
		local right_sep = hl_str(separator_icon.right, "SLSeparator", "SLSeparator")
		return left_sep .. hl_str(" " .. filetype_str .. " ", "SLFiletype", "SLFiletype") .. right_sep
	end,
}

local breadcrumb = function()
	local breadcrumb_status_ok, breadcrumb = pcall(require, "breadcrumb")
	if not breadcrumb_status_ok then
		return
	end
	return breadcrumb.get_breadcrumb()
end

local normal_hl = tvl.get_highlight("Normal")
local no_theme = {
	normal = {
		a = { fg = normal_hl.background, bg = normal_hl.background, gui = "bold" },
		b = { fg = normal_hl.background, bg = normal_hl.background },
		c = { fg = normal_hl.background, bg = normal_hl.background },
		x = { fg = normal_hl.background, bg = normal_hl.background },
		y = { fg = normal_hl.background, bg = normal_hl.background },
		z = { fg = normal_hl.background, bg = normal_hl.background },
	},
	insert = { a = { fg = normal_hl.background, bg = normal_hl.background, gui = "bold" } },
	visual = { a = { fg = normal_hl.background, bg = normal_hl.background, gui = "bold" } },
	command = { a = { fg = normal_hl.background, bg = normal_hl.background, gui = "bold" } },
	replace = { a = { fg = normal_hl.background, bg = normal_hl.background, gui = "bold" } },
	inactive = {
		a = { fg = normal_hl.background, bg = normal_hl.background },
		b = { fg = normal_hl.background, bg = normal_hl.background },
		c = { fg = normal_hl.background, bg = normal_hl.background },
		x = { fg = normal_hl.background, bg = normal_hl.background },
		y = { fg = normal_hl.background, bg = normal_hl.background },
		z = { fg = normal_hl.background, bg = normal_hl.background },
	},
}

local float_config = {
	options = {
		theme = no_theme,
		icons_enabled = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = { "neo-tree" },
			"alpha",
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { padding_pad, branch },
		lualine_b = { diagnostics },
		lualine_c = {},
		lualine_x = { diff },
		lualine_y = { position, filetype },
		lualine_z = { spaces, mode, padding_pad },
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
	winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { breadcrumb },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { breadcrumb },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = {},
}

lualine.setup(float_config)
