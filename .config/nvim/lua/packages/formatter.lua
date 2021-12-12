return {
	"mhartington/formatter.nvim",
	config = function()
		require("formatter").setup({
			filetype = {
				html = {
					-- prettier
					function()
						return {
							exe = "prettier",
							args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
							stdin = true,
						}
					end,
				},
				typescript = {
					-- prettier
					function()
						return {
							exe = "prettier",
							args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
							stdin = true,
						}
					end,
				},
				javascript = {
					-- prettier
					function()
						return {
							exe = "prettier",
							args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
							stdin = true,
						}
					end,
				},
				svelte = {
					-- prettier
					function()
						return {
							exe = "prettier",
							args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
							stdin = true,
						}
					end,
				},
				rust = {
					-- Rustfmt
					function()
						return {
							exe = "rustfmt",
							args = { "--emit=stdout" },
							stdin = true,
						}
					end,
				},
				lua = {
					function()
						return {
							exe = "stylua",
							args = {
								--   "--config-path "
								--   .. os.getenv("XDG_CONFIG_HOME")
								--   .. "/stylua/stylua.toml",
								"-",
							},
							stdin = true,
						}
					end,
				},
			},
		})
	end,
}
