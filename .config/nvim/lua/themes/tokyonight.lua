return {
	"folke/tokyonight.nvim",
	config = function()
		-- Tokyo Night settings
		-- The theme comes in two styles, 'storm' and a darker variant 'night'.
		vim.g.tokyonight_style = "night"

		-- Comments are italicized by default
		vim.g.tokyonight_italic_comments = 1

		-- Keywords are italicized by default
		vim.g.tokyonight_italic_keywords = 1

		-- Functions are not italicized by default
		vim.g.tokyonight_italic_functions = 0

		-- Enable this to disable setting the background color
		vim.g.tokyonight_transparent = 0

		-- Enabling this option, will hide inactive statuslines and
		-- replace them with a thin border instead. Should work with
		-- the standard `StatusLine` and `LuaLine`.
		vim.g.tokyonight_hide_inactive_statusline = 0
	end,
}
