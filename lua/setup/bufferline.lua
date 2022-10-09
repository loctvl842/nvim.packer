local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup({
	options = {
		mode = "buffers",
		numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		-- NOTE: this plugin is designed with this icon in mind,
		-- and so changing this is NOT recommended, this is intended
		-- as an escape hatch for people who cannot bear it for whatever reason
		indicator = {
			-- icon = "▏",
			style = "underline",
		},
		buffer_close_icon = "",
		-- buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		-- close_icon = '',
		left_trunc_marker = "",
		right_trunc_marker = "",
		--- name_formatter can be used to change the buffer's label in the bufferline.
		--- Please note some names can/will break the
		--- bufferline so use this at your discretion knowing that it has
		--- some limitations that will *NOT* be fixed.
		-- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
		--   -- remove extension from markdown files for example
		--   if buf.name:match('%.md') then
		--     return vim.fn.fnamemodify(buf.name, ':t:r')
		--   end
		-- end,
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 21,
		diagnostics = false, -- | "nvim_lsp" | "coc",
		diagnostics_update_in_insert = false,
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			return "(" .. count .. ")"
			-- return ""
		end,
		-- NOTE: this will be called a lot so don't do any heavy processing here
		-- custom_filter = function(buf_number)
		--   -- filter out filetypes you don't want to see
		--   if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
		--     return true
		--   end
		--   -- filter out by buffer name
		--   if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
		--     return true
		--   end
		--   -- filter out based on arbitrary rules
		--   -- e.g. filter out vim wiki buffer from tabline in your work repo
		--   if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
		--     return true
		--   end
		-- end,
		offsets = {
			{
				filetype = "neo-tree",
				text = "EXPLORER",
				padding = 0,
				text_align = "left",
				highlight = "Offset",
			},
		},
		color_icons = true,
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = false,
		show_duplicate_prefix = true,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = "slant", -- | "thick" | "thin" | { 'any', 'any' },
		enforce_regular_tabs = true,
		always_show_bufferline = true,
		sort_by = "insert_after_current",
		-- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
		--   -- add custom logic
		--   return buffer_a.modified > buffer_b.modified
		-- end
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},
	},
	highlights = {
		fill = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineFill",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineFill",
			},
		},
		background = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineBackground",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineBackground",
			},
		},
		close_button = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineCloseButton",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineCloseButton",
			},
		},
		close_button_selected = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineCloseButtonSelected",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineCloseButtonSelected",
			},
		},
		close_button_visible = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineCloseButtonVisible",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineCloseButtonVisible",
			},
		},
		separator = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineSeparator",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineSeparator",
			},
		},
		separator_selected = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineSeparatorSelected",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineSeparatorSelected",
			},
		},
		separator_visible = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineSeparatorVisible",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineSeparatorVisible",
			},
		},
		indicator_selected = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineIndicatorSelected",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineIndicatorSelected",
			},
		},
		buffer_selected = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineBufferSelected",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineBufferSelected",
			},
		},
		buffer_visible = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineBufferVisible",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineBufferVisible",
			},
		},
		modified = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineModified",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineModified",
			},
		},
		modified_selected = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineModifiedSelected",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineModifiedSelected",
			},
		},
		modified_visible = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineModifiedVisible",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineModifiedVisible",
			},
		},
		error = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineError",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineError",
			},
		},
		error_selected = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineErrorSelected",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineErrorSelected",
			},
		},
		error_visible = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineErrorVisible",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineErrorVisible",
			},
		},
		error_diagnostic = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineErrorDiagnostic",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineErrorDiagnostic",
			},
		},
		error_diagnostic_visible = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineErrorDiagnosticVisible",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineErrorDiagnosticVisible",
			},
		},
		error_diagnostic_selected = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineErrorDiagnosticSelected",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineErrorDiagnosticSelected",
			},
		},
		info = {
			fg = {
				attribute = "fg",
				highlight = "BufferLineInfo",
			},
			bg = {
				attribute = "bg",
				highlight = "BufferLineInfo",
			},
		},
	},
})
