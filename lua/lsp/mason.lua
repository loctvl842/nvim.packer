local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_mason_lspconfig then
	return
end

local servers = {
	"clangd",
	"cssls",
	"html",
	"jsonls",
	"sumneko_lua",
	"tsserver",
	"pyright",
}

local settings = {
	ui = {
		border = "rounded",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local status_ok_lspconfig, lspconfig = pcall(require, "lspconfig")
if not status_ok_lspconfig then
	return
end

local opts = {}
for _, server in pairs(servers) do
	opts = {
		capabilities = require("lsp.handlers").capabilities,
		on_attach = require("lsp.handlers").on_attach,
	}
	if server == "jsonls" then
		local jsonls_opts = require("lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end
	if server == "emmet_ls" then
		local emmet_ls_opts = require("lsp.settings.emmet_ls")
		opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
	end
	if server == "sumneko_lua" then
		local sumneko_opts = require("lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end
	if server == "tsserver" then
		local tsserver_opts = require("lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
	end

	lspconfig[server].setup(opts)
end
