_G.tvl = {}
local stdpath = vim.fn.stdpath

local config_path = stdpath("config")

--- Looks to see if a module path references a lua file in a configuration folder and tries to load it. If there is an error loading the file, write an error and continue
-- @param module the module path to try and load
-- @return the loaded module if successful or nil
local function load_module_file(module)
	-- placeholder for final return value
	local found_module = nil
	-- search through each of the supported configuration locations
	-- convert the module path to a file path (example user.init -> user/init.lua)
	local module_path = config_path .. "/lua/" .. module:gsub("%.", "/") .. ".lua"
	-- check if there is a readable file, if so, set it as found
	if vim.fn.filereadable(module_path) == 1 then
		found_module = module_path
	end
	-- if we found a readable lua file, try to load it
	if found_module then
		-- try to load the file
		local status_ok, loaded_module = pcall(require, module)
		-- if successful at loading, set the return variable
		if status_ok then
			found_module = loaded_module
			-- if unsuccessful, throw an error
		else
			vim.api.nvim_err_writeln("Error loading file: " .. found_module .. "\n\n" .. loaded_module)
		end
	end
	-- return the loaded module or nil if no file found
	return found_module
end

--- Search the user settings (user/init.lua table) for a table with a module like path string
-- @param module the module path like string to look up in the user settings table
-- @return the value of the table entry if exists or nil
local function user_setting_table(module)
	-- get the user settings table
	local settings = tvl.user_settings or {}
	-- iterate over the path string split by '.' to look up the table value
	for tbl in string.gmatch(module, "([^%.]+)") do
		settings = settings[tbl]
		-- if key doesn't exist, keep the nil value and stop searching
		if settings == nil then
			break
		end
	end
	-- return the found settings
	return settings
end

--- Main configuration engine logic for extending a default configuration table with either a function override or a table to merge into the default option
-- @function tvl.func_or_extend
-- @param overrides the override definition, either a table or a function that takes a single parameter of the original table
-- @param default the default configuration table
-- @param extend boolean value to either extend the default or simply overwrite it if an override is provided
-- @return the new configuration table
local function func_or_extend(overrides, default, extend)
	-- if we want to extend the default with the provided override
	if extend then
		-- if the override is a table, use vim.tbl_deep_extend
		if type(overrides) == "table" then
			default = tvl.default_tbl(overrides, default)
			-- if the override is  a function, call it with the default and overwrite default with the return value
		elseif type(overrides) == "function" then
			default = overrides(default)
		end
		-- if extend is set to false and we have a provided override, simply override the default
	elseif overrides ~= nil then
		default = overrides
	end
	-- return the modified default table
	return default
end

--- User configuration entry point to override the default options of a configuration table with a user configuration file or table in the user/init.lua user settings
-- @param module the module path of the override setting
-- @param default the default settings that will be overridden
-- @param extend boolean value to either extend the default settings or overwrite them with the user settings entirely (default: true)
-- @param prefix a module prefix for where to search (default: user)
-- @return the new configuration settings with the user overrides applied
function tvl.user_plugin_opts(module, default, extend, prefix)
	-- default to extend = true
	if extend == nil then
		extend = true
	end
	-- if no default table is provided set it to an empty table
	default = default or {}
	-- try to load a module file if it exists
	local user_settings = load_module_file((prefix or "user") .. "." .. module)
	-- if no user module file is found, try to load an override from the user settings table from user/init.lua
	if user_settings == nil and prefix == nil then
		user_settings = user_setting_table(module)
	end
	-- if a user override was found call the configuration engine
	if user_settings ~= nil then
		default = func_or_extend(user_settings, default, extend)
	end
	-- return the final configuration table with any overrides applied
	return default
end
