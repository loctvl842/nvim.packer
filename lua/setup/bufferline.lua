local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup({
	options = {
		numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		-- NOTE: this plugin is designed with this icon in mind,
		-- and so changing this is NOT recommended, this is intended
		-- as an escape hatch for people who cannot bear it for whatever reason
		indicator_icon = "▏",
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
			-- return "(" .. count .. ")"
			return ""
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
				text = " EXPLORER",
				padding = 0,
				text_align = "left",
				highlight = "Offset",
			},
		},
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = false,
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
	},
	highlights = {
		fill = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineFill",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineFill",
			},
		},
		background = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineBackground",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineBackground",
			},
		},
		close_button = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineCloseButton",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineCloseButton",
			},
		},
		close_button_selected = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineCloseButtonSelected",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineCloseButtonSelected",
			},
		},
		close_button_visible = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineCloseButtonVisible",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineCloseButtonVisible",
			},
		},
		separator = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineSeparator",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineSeparator",
			},
		},
		separator_selected = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineSeparatorSelected",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineSeparatorSelected",
			},
		},
		separator_visible = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineSeparatorVisible",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineSeparatorVisible",
			},
		},
		indicator_selected = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineIndicatorSelected",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineIndicatorSelected",
			},
		},
		buffer_selected = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineBufferSelected",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineBufferSelected",
			},
		},
		buffer_visible = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineBufferVisible",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineBufferVisible",
			},
		},
		modified = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineModified",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineModified",
			},
		},
		modified_selected = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineModifiedSelected",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineModifiedSelected",
			},
		},
		modified_visible = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineModifiedVisible",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineModifiedVisible",
			},
		},
		error = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineError",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineError",
			},
		},
		error_selected = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineErrorSelected",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineErrorSelected",
			},
		},
		error_visible = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineErrorVisible",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineErrorVisible",
			},
		},
		error_diagnostic = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineErrorDiagnostic",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineErrorDiagnostic",
			},
		},
		error_diagnostic_visible = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineErrorDiagnosticVisible",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineErrorDiagnosticVisible",
			},
		},
		error_diagnostic_selected = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineErrorDiagnosticSelected",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineErrorDiagnosticSelected",
			},
		},
		info = {
			guifg = {
				attribute = "fg",
				highlight = "BufferLineInfo",
			},
			guibg = {
				attribute = "bg",
				highlight = "BufferLineInfo",
			},
		},
	},
})