local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
	impatient.enable_profile()
end

for _, source in
	ipairs({
		"core.utils",
		"core.plugins",
		"core.autocommands",
		"core.keymaps",
		"core.options",
		"lsp",
	})
do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
	end
end
