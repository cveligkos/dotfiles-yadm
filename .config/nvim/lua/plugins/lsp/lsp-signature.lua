local lsp_signature_setup, lsp_signature = pcall(require, "lsp_signature")
if not lsp_signature_setup then
	return
end

lsp_signature.setup({})
