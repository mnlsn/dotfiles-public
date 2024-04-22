local M = {}

function M.toggleInlayHints()
	vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
end

function M.toggleDiagnosticVirtualText()
	vim.lsp.diagnostic.display_virtual_text = not vim.lsp.diagnostic.display_virtual_text
end

function M.toggleDiagnostics()
	vim.lsp.diagnostic.display = not vim.lsp.diagnostic.display
end

vim.api.nvim_create_user_command("ToggleDiagnosticVirtualText", function()
	vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
end, { nargs = 0 })

vim.api.nvim_create_user_command("ToggleDiagnostics", function()
	vim.lsp.diagnostic.display = not vim.lsp.diagnostic.display
end, { nargs = 0 })

return M
