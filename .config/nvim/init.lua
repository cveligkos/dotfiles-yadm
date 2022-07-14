-- vim:fileencoding=utf-8:foldmethod=marker

--{{{ packages
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'williamboman/nvim-lsp-installer'
  -- Configurations for Nvim LSP
  use 'neovim/nvim-lspconfig'

  -- {{{ Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  -- }}}

  use 'onsails/lspkind.nvim'

  use 'rafamadriz/friendly-snippets'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use "lukas-reineke/indent-blankline.nvim"
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  use 'kevinhwang91/rnvimr'

  use {
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  }

  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }

  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }


  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require'hop'.setup {}
    end
  }

  -- barbar
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  use 'bluz71/vim-nightfly-guicolors'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
--}}}

require("config.lsp")
require("config.completion")

-- {{{ Options
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.clipboard = unnamed
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 10
-- }}}

vim.cmd([[
augroup FormatOptions
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
]])

vim.cmd("runtime mappings.vim")

-- Themes
vim.cmd("colorscheme nightfly")

-- Start lualine
require('lualine').setup()
