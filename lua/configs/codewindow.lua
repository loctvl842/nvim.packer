local status_ok, codewindow = pcall(require, "codewindow")
if not status_ok then
	return
end

codewindow.setup({
	minimap_width = 15, -- The width of the text part of the minimap
	width_multiplier = 3, -- How many characters one dot represents
	use_lsp = true, -- Use the builtin LSP to show errors and warnings
	use_treesitter = true, -- Use nvim-treesitter to highlight the code
	exclude_filetypes = { "neo-tree" }, -- Choose certain filetypes to not show minimap on
	z_index = 1, -- The z-index the floating window will be on
})

codewindow.apply_default_keybinds()
