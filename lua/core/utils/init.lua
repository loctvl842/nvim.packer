_G.tvl = {}

local stdpath = vim.fn.stdpath
tvl.compile_path = stdpath("data") .. "/packer_compiled.lua"

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

local colorscheme_ok, monokai_pro = pcall(require, "monokai-pro")
if colorscheme_ok then
	tvl.color_base = monokai_pro.get_base_color()
end

--- Serve a notification with a title of TVL
-- @param msg the notification body
-- @param type the type of the notification (:help vim.log.levels)
-- @param opts table of nvim-notify options to use (:help notify-options)
function tvl.notify(msg, type, opts)
	vim.schedule(function()
		vim.notify(msg, type, tvl.default_tbl(opts, { title = "TVL" }))
	end)
end

--- Check if packer is installed and loadable, if not then install it and make sure it loads
function tvl.initialize_packer()
  -- try loading packer
  local packer_path = stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
  local packer_avail = vim.fn.empty(vim.fn.glob(packer_path)) == 0
  -- if packer isn't availble, reinstall it
  if not packer_avail then
    -- set the location to install packer
    -- clone packer
    vim.fn.system {
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      packer_path,
    }
    local packer_loaded, _ = pcall(require, "packer")
    packer_avail = packer_loaded
    -- if packer didn't load, print error
    if not packer_avail then vim.api.nvim_err_writeln("Failed to load packer at:" .. packer_path) end
  end
  -- if packer is available, check if there is a compiled packer file
  if packer_avail then
    -- try to load the packer compiled file
    local run_me, _ = loadfile(
      tvl.compile_path
    )
    if run_me then
      -- if the file loads, run the compiled function
      run_me()
    end
  end
end

require("core.utils.lsp")

return tvl
