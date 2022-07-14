require("plugins")
require("config.lsp")
require("config.completion")

-- Options
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.clipboard = unnamed
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 10

vim.cmd([[
augroup FormatOptions
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
]])

vim.cmd("runtime mappings.vim")

-- Themes
vim.cmd("colorscheme desert")
