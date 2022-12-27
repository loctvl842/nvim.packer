tvl.lsp = {}

local status_ok_lspconfig, lspconfig = pcall(require, "lspconfig")
if not status_ok_lspconfig then
	return
end

tvl.lsp.servers = {
	"clangd",
	"cssls",
	"html",
	"jsonls",
	"sumneko_lua",
	"tsserver",
	"pyright",
	"bashls",
	"jdtls",
	"cssmodules_ls",
	"lemminx",
}

--- Get the specic setting for one languege which is set up in folder server_settings
tvl.lsp.language_opts = function(server_name)
	local status_ok, lang_opts = pcall(require, "core.utils.server_settings." .. server_name)
	if not status_ok then
		return {}
	end
	return lang_opts
end

--- The default LSP capabilities
tvl.lsp.capabilities = vim.lsp.protocol.make_client_capabilities()
tvl.lsp.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
tvl.lsp.capabilities.textDocument.completion.completionItem.snippetSupport = true
tvl.lsp.capabilities.textDocument.completion.completionItem.preselectSupport = true
tvl.lsp.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
tvl.lsp.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
tvl.lsp.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
tvl.lsp.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
tvl.lsp.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
tvl.lsp.capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "documentation", "detail", "additionalTextEdits" },
}

--- The `attach_breadcrumb` function used by on_attach to get breadcrumb info
-- @param client the LSP client details when attaching
-- @param bufnr the number of the buffer that the LSP client is attaching to
tvl.lsp.attach_breadcrumb = function(client, bufnr)
	local status_ok, breadcrumb = pcall(require, "breadcrumb")
	if not status_ok then
		return
	end
  if client.server_capabilities.documentSymbolProvider then
    breadcrumb.attach(client, bufnr)
  end
end

--- The `attach_inlayhints` function used by on_attach function
-- @param client the LSP client details when attaching
-- @param bufnr the number of the buffer that the LSP client is attaching to
tvl.lsp.attach_inlayhints = function(client, bufnr)
	local status_inlay_hints_ok, inlay_hints = pcall(require, "lsp-inlayhints")
	if not status_inlay_hints_ok then
		return
	end
	inlay_hints.on_attach(client, bufnr)
end

tvl.lsp.lsp_mappings = function(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap(bufnr, "n", "<leader>rn", "<cmd>lua require('renamer').rename()<CR>", opts)
	keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", opts)
	keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

--- The `on_attach` function
-- @param client the LSP client details when attaching
-- @param bufnr the number of the buffer that the LSP client is attaching to
tvl.lsp.on_attach = function(client, bufnr)
	tvl.lsp.lsp_mappings(bufnr)
	tvl.lsp.attach_breadcrumb(client, bufnr)
	if client.name == "jdt.ls" then
		vim.lsp.codelens.refresh()
		if JAVA_DAP_ACTIVE then
			require("jdtls").setup_dap({ hotcodereplace = "auto" })
			require("jdtls.dap").setup_dap_main_class_configs()
		end
	end
end

--- Get the server settings for a given language server to be provided to the server's `setup()` call
-- @param  server_name the name of the server
-- @return the table of LSP options used when setting up the given language server
function tvl.lsp.server_settings(server_name)
	local server = require("lspconfig")[server_name]
	local opts = {
		capabilities = vim.tbl_deep_extend("force", tvl.lsp.capabilities, server.capabilities or {}),
		on_attach = tvl.lsp.on_attach,
	}
	local lang_opts = tvl.lsp.language_opts(server_name)
	opts = vim.tbl_deep_extend("force", lang_opts, opts)
	return opts
end

--- Helper function to set up a given server with the Neovim LSP client. Map in `lspconfig.lua`
-- @param server the name of the server to be setup
tvl.lsp.setup = function(server)
	local opts = tvl.lsp.server_settings(server)
	lspconfig[server].setup(opts)
end

return tvl.lsp
