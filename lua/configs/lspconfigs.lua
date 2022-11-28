vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = { "▄", "▄", "▄", "█", "▀", "▀", "▀", "█" },
	width = 60,
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = { "▄", "▄", "▄", "█", "▀", "▀", "▀", "█" },
	width = 60,
})
vim.tbl_map(tvl.lsp.setup, tvl.lsp.servers)
