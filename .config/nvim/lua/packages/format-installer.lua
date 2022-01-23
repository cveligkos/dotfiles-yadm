return {
	"jose-elias-alvarez/null-ls.nvim",
	requires = "PlatyPew/format-installer.nvim",
	after = "nvim-lspconfig", -- To prevent null-ls from failing to read buffer
	config = function ()
	local null_ls = require'null-ls'
local formatter_install = require'format-installer'

local sources = {}
for _, formatter in ipairs(formatter_install.get_installed_formatters()) do
    local config = { command = formatter.cmd }
    table.insert(sources, null_ls.builtins.formatting[formatter.name].with(config))
end

null_ls.setup({
    sources = sources,
})	
	end
}
