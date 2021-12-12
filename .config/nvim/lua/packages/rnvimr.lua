return {
	"kevinhwang91/rnvimr",
	config = function()
		-- Make Ranger replace Netrw and be the file explorer
		vim.g.rnvimr_enable_ex = 1

		-- Make Ranger to be hidden after picking a file
		vim.g.rnvimr_enable_picker = 1
	end,
}
