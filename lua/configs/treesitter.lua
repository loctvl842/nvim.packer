local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "phpdoc", "tree-sitter-phpdoc" }, -- List of parsers to ignore installing
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		-- disable = { "scss", "css" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true, disable = { "yaml", "python" } },
	context_commentstring = {
		enable = true,
	},
	autotag = {
		enable = true,
		disable = { "xml", "markdown" },
	},
	rainbow = {
		enable = true,
		extended_mode = false,
		colors = {
			tvl.color_base.blue,
			tvl.color_base.red,
			tvl.color_base.magenta,
			tvl.color_base.cyan,
			tvl.color_base.green,
			tvl.color_base.yellow,
		},
		disable = { "html" },
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
})
