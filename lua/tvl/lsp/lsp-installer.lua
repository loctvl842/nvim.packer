local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local servers = { "clangd", "cssls", "html", "jsonls", "sumneko_lua", "tsserver", "pyright" }

lsp_installer.setup({
	ensure_installed = servers,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		capabilities = require("tvl.lsp.handlers").capabilities,
		on_attach = require("tvl.lsp.handlers").on_attach,
	}
	if server == "jsonls" then
		local jsonls_opts = require("tvl.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end
	if server == "emmet_ls" then
		local emmet_ls_opts = require("tvl.lsp.settings.emmet_ls")
		opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
	end
	if server == "sumneko_lua" then
		local sumneko_opts = require("tvl.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	lspconfig[server].setup(opts)
end
