return {
	"neovim/nvim-lspconfig",
	config = function()
		-- rust-analyzer
		require("lspconfig").rust_analyzer.setup({})

		-- vimls
		require("lspconfig").vimls.setup({})

		-- svelte
		require("lspconfig").svelte.setup({})

		-- clangd
		require("lspconfig").clangd.setup({})

		-- cssls
		--Enable (broadcasting) snippet capability for completion
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		require("lspconfig").cssls.setup({
			capabilities = capabilities,
		})

		-- tsserver
		-- require'lspconfig'.tsserver.setup { }

		-- require'lspconfig'.html.setup {
		--   capabilities = capabilities,
		--   filetypes = { "html", "eruby" }
		-- }
	end,
}
