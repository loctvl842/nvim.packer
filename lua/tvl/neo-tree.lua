local status_ok, neoTree = pcall(require, "neo-tree")
if not status_ok then
	return
end

neoTree.setup({
	close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	default_component_configs = {
		container = {
			enable_character_fade = true,
		},
		indent = {
			indent_size = 1.5,
			padding = 0, -- extra padding on left hand side
			-- indent guides
			with_markers = false,
			-- indent_marker = "│",
			-- last_indent_marker = "└",
			indent_marker = "▏",
			last_indent_marker = "▏",
			highlight = "NeoTreeIndentMarker",
			-- expander config, needed for nesting files
			with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			-- folder_closed = "",
			-- folder_open = "",
			folder_empty = " ",
			default = " ",
			highlight = "NeoTreeFileIcon",
		},
		modified = {
			symbol = "[+]",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			use_git_status_colors = true,
			highlight = "NeoTreeFileName",
		},
		git_status = {
			symbols = {
				-- Change type
				added = "A", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "M", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "D", -- this can only be used in the git_status source
				renamed = "", -- this can only be used in the git_status source
				-- Status type
				untracked = "U",
				ignored = "",
				-- unstaged = "",
				unstaged = "",
				staged = "S",
				conflict = "",
			},
		},
	},
	window = {
		position = "left",
		width = 30,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["<space>"] = {
				"toggle_node",
				nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
			},
			["<1-LeftMouse>"] = "open",
			["<cr>"] = "open",
			["l"] = "open",
			["S"] = "open_split",
			["s"] = "open_vsplit",
			-- ["S"] = "split_with_window_picker",
			-- ["s"] = "vsplit_with_window_picker",
			["t"] = "open_tabnew",
			["w"] = "open_with_window_picker",
			["C"] = "close_node",
			["a"] = {
				"add",
				-- some commands may take optional config options, see `:h neo-tree-mappings` for details
				config = {
					show_path = "none", -- "none", "relative", "absolute"
				},
			},
			["A"] = "add_directory", -- also accepts the config.show_path option.
			["d"] = "delete",
			["r"] = "rename",
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["c"] = "copy", -- takes text input for destination
			["m"] = "move", -- takes text input for destination
			["q"] = "close_window",
			["R"] = "refresh",
			["?"] = "show_help",
		},
	},
	nesting_rules = {
		-- ["js"] = { "js.map" },
	},
	filesystem = {
		filtered_items = {
			visible = false, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_by_name = {
				--"node_modules"
			},
			hide_by_pattern = { -- uses glob style patterns
				--"*.meta"
			},
			never_show = { -- remains hidden even if visible is toggled to true
				--".DS_Store",
				--"thumbs.db"
			},
		},
		follow_current_file = true, -- This will find and focus the file in the active buffer every
		-- time the current file is changed while the tree is open.
		group_empty_dirs = false, -- when true, empty folders will be grouped together
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
		-- in whatever position is specified in window.position
		-- "open_current",  -- netrw disabled, opening a directory opens within the
		-- window like netrw would, regardless of window.position
		-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
		use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
		-- instead of relying on nvim autocmd events.
		window = {
			mappings = {
				["H"] = "navigate_up",
				["<bs>"] = "toggle_hidden",
				["."] = "set_root",
				["/"] = "fuzzy_finder",
				["f"] = "filter_on_submit",
				["<c-x>"] = "clear_filter",
				["[g"] = "prev_git_modified",
				["]g"] = "next_git_modified",
			},
		},
		components = {
			name = function(config, node, state)
				local highlight = "NeoTreeFileName"
				if node.type == "directory" then
					highlight = "NeoTreeDirectoryName"
				end
				if node:get_depth() == 1 then
					highlight = "NeoTreeRootName"
				else
					if config.use_git_status_colors == nil or config.use_git_status_colors then
						local git_status = state.components.git_status({}, node, state)
						if git_status and git_status.highlight then
							highlight = git_status.highlight
						end
					end
				end
				-- make root-folder shorter and upper-case
				local function newName(name)
					if name:sub(1, 1) == "~" then
						local function split(inputstr, sep)
							if sep == nil then
								sep = "%s"
							end
							local t = {}
							for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
								table.insert(t, str)
							end
							return t
						end

						local dirs = split(name, "/")
						local ans = dirs[#dirs]
						return string.upper(ans)
					else
						return name
					end
				end

				node.name = newName(node.name)

				return {
					text = node.name,
					highlight = highlight,
				}
			end,
			icon = function(config, node, state)
				local icon = config.default or " "
				local highlight = "NeoTreeFileIcon"
				if node.type == "directory" then
					highlight = "NeoTreeDirectoryIcon"
					if node.loaded and not node:has_children() then
						icon = config.folder_empty or config.folder_open or "-"
					elseif node:is_expanded() then
						icon = config.folder_open or "-"
					else
						icon = config.folder_closed or "+"
					end
					if node:get_depth() == 1 then
						highlight = "NeoTreeRootName"
					else
						if config.use_git_status_colors == nil or config.use_git_status_colors then
							local git_status = state.components.git_status({}, node, state)
							if git_status and git_status.highlight then
								highlight = git_status.highlight
							end
						end
					end
				elseif node.type == "file" or node.type == "terminal" then
					local success, web_devicons = pcall(require, "dev-icons")
					if success then
						local devicon, hl = web_devicons.get_icon(node.name, node.ext)
						icon = devicon or icon
						highlight = hl or highlight
					end
				end
				-- Don't render icon in root folder
				if node:get_depth() == 1 then
					return {
						text = "",
						highlight = highlight,
					}
					-- Don't insert space between icon and filename (Only have a space in icon)
				else
					return {
						text = icon .. " ",
						highlight = highlight,
					}
				end
			end,
		},
	},
	buffers = {
		follow_current_file = true, -- This will find and focus the file in the active buffer every
		-- time the current file is changed while the tree is open.
		group_empty_dirs = true, -- when true, empty folders will be grouped together
		show_unloaded = true,
		window = {
			mappings = {
				["bd"] = "buffer_delete",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
			},
		},
	},
	git_status = {
		window = {
			position = "float",
			mappings = {
				["A"] = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
			},
		},
	},
})
