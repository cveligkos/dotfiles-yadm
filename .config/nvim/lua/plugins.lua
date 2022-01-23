local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

vim.cmd([[packadd packer.nvim]])

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function()
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	-- use(require("packages.vim-sensible"))
	use(require("packages.gitsigns"))
	use(require("packages.telescope-fzf-native"))
	use(require("packages.telescope"))
	use(require("packages.web-devicons"))
	use(require("packages.lualine"))
	use(require("packages.stabilize"))
	-- "   use 'b3nj5m1n/kommentary'

	use(require("packages.format-installer"))
	-- use(require("packages.formatter"))
	use(require("packages.lspconfig"))
	use(require("packages.lsp-installer"))
	use(require("packages.commentary"))
	use(require("packages.treesitter"))
	use(require("packages.ts-context-commentstring"))
	use(require("packages.ts-autotag"))
	use(require("packages.rnvimr"))
	use(require("packages.polyglot"))
	use(require("packages.kitty"))
	use(require("packages.lsp-signature"))
	use(require("packages.surround"))
	use(require("packages.friendly-snippets"))
	use(require("packages.svelte-snippets"))
	use(require("packages.luasnip"))

	use(require("packages.cmp_luasnip"))
	use(require("packages.cmp-buffer"))
	use(require("packages.cmp-nvim-lsp"))
	use(require("packages.cmp-path"))
	use(require("packages.cmp-cmdline"))
	use(require("packages.cmp"))
	use(require("packages.lspkind"))
	use(require("packages.hlslens"))
	use(require("packages.neuron"))

	use("nvim-lua/popup.nvim")

	use(require("packages.svelte"))
	use(require("packages.nvim-tree"))

	-- use 'windwp/nvim-spectre'
	use(require("packages.indent-blankline"))
	use(require("packages.autopairs"))
	use(require("packages.colorizer"))
	use(require("packages.trouble"))

	use("tpope/vim-repeat")
	use(require("packages.lightspeed"))

	-- " Themes
	use(require("themes.tokyonight"))
	use(require("themes.onenord"))
	use(require("themes.nightfox"))

	if packer_bootstrap then
		require("packer").sync()
	end
end)
