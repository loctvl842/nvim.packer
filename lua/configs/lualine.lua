local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
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
		return hl_str("    ", "SLPadding")
	end,
	padding = 0,
}

local left_pad_alt = {
	function()
		return hl_str(" ", "SLSeparator")
	end,
	padding = 0,
}

local right_pad_alt = {
	function()
		return hl_str("  ", "SLSeparator")
	end,
	padding = 0,
}

local right_pad_alt_1 = {
	function()
		return hl_str(" ", "SLSeparator")
	end,
	padding = 0,
}

local left_pad = {
	function()
		return hl_str(" ", "SLSeparator")
		-- return hl_str(" ", "SLSeparator")
	end,
	padding = 0,
}

local right_pad = {
	function()
		return hl_str(" ", "SLSeparator")
		-- return hl_str(" ", "SLSeparator")
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

	on_click = function()
		vim.diagnostic.setloclist()
	end,
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
		-- local mode_str = " " .. str
		local mode_str = str
		return hl_str(mode_str, "SLMode", "SLMode")
	end,
}

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
		else
			prev_filetype = str
			filetype_str = str
		end
		return hl_str(filetype_str, "SLFiletype", "SLFiletype")
	end,
}

local breadcrumb = function()
	local breadcrumb_status_ok, breadcrumb = pcall(require, "breadcrumb")
	if not breadcrumb_status_ok then
		return
	end
	return breadcrumb.get_breadcrumb()
end

local config = {
	options = {
		icons_enabled = true,
		theme = "auto",
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
		lualine_a = { padding_pad, left_pad, branch, right_pad },
		lualine_b = { left_pad_alt, diagnostics, right_pad_alt },
		lualine_c = {},
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { left_pad_alt, mode, right_pad_alt_1 },
		lualine_y = { left_pad, position, right_pad, left_pad, filetype, right_pad },
		lualine_z = { left_pad, spaces, right_pad, left_pad, encoding, right_pad, padding_pad },
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

lualine.setup(config)
