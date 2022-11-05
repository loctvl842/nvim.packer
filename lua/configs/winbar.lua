local status_ok, winbar = pcall(require, "winbar")
if not status_ok then
	return
end

winbar.setup({
	disabled_filetype = {
		"packer",
		"alpha",
		"WhichKey",
		"toggleterm",
		"neo-tree",
		"Compile",
		"TelescopePrompt",
		"TelescopeResult",
		"Codewindow",
	},
	--  -- VSCode icons
	-- icons = {
	-- 	File = " ",
	-- 	Module = " ",
	-- 	Namespace = " ",
	-- 	Package = " ",
	-- 	Class = " ",
	-- 	Method = " ",
	-- 	Property = " ",
	-- 	Field = " ",
	-- 	Constructor = " ",
	-- 	Enum = " ",
	-- 	Interface = " ",
	-- 	Function = " ",
	-- 	Variable = " ",
	-- 	Constant = " ",
	-- 	String = " ",
	-- 	Number = " ",
	-- 	Boolean = " ",
	-- 	Array = " ",
	-- 	Object = " ",
	-- 	Key = " ",
	-- 	Null = " ",
	-- 	EnumMember = " ",
	-- 	Struct = " ",
	-- 	Event = " ",
	-- 	Operator = " ",
	-- 	TypeParameter = " ",
	-- },
	separator = require("icons").ui.ChevronRight,
	-- limit for amount of context shown
	-- 0 means no limit
	-- Note: to make use of depth feature properly, make sure your separator isn't something that can appear
	-- in context names (eg: function names, class names, etc)
	depth = 0,
	-- indicator used when context hits depth limit
	depth_limit_indicator = "..",
	highlight_group = {
		component = "WinbarText",
		separator = "WinbarSeparator",
	},
})
