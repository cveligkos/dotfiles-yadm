local setup, zen_mode = pcall(require, "zen-mode")
if not setup then
	return
end

zen_mode.setup({})
