_G.tvl = {}

-- @param highlight group to get (string)
-- @return table { foreground, background }
function tvl.get_highlight(group)
	local hl = vim.api.nvim_get_hl_by_name(group, true)
  local hl_config = {}
  for key, value in pairs(hl) do
    hl_config[key] = string.format("#%02x", value)
  end
  return hl_config
end

require("core.utils.lsp")
require("core.utils.diagnostics")

return tvl
