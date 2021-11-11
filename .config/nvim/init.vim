" vim:fdm=marker

" vim-plug {{{
" =================================
" Auto install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

" sensible.vim: Defaults everyone can agree on
Plug 'tpope/vim-sensible'

Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Plug 'ptzz/lf.vim'
" Plug 'voldikss/vim-floaterm'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'noib3/cokeline.nvim'

Plug 'luukvbaal/stabilize.nvim'

" Plug 'b3nj5m1n/kommentary'
Plug 'tpope/vim-commentary'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

" Plug 'tweekmonster/startuptime.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-ts-autotag'
Plug 'sheerun/vim-polyglot'

Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'ray-x/lsp_signature.nvim'

Plug 'tpope/vim-surround'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'onsails/lspkind-nvim'


" Plug 'vimwiki/vimwiki', {'branch': 'dev'}
" Plug 'ledger/vim-ledger'

Plug 'leafOfTree/vim-svelte-plugin'

Plug 'kyazdani42/nvim-tree.lua'

Plug 'windwp/nvim-spectre'
Plug 'mhartington/formatter.nvim'

Plug 'windwp/nvim-autopairs'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'folke/trouble.nvim'

" Themes
" Plug 'glepnir/zephyr-nvim'
Plug 'EdenEast/nightfox.nvim'
" Plug 'folke/tokyonight.nvim'
" Plug 'shaunsingh/nord.nvim'
Plug 'rmehri01/onenord.nvim'

call plug#end()

" }}}

" Options {{{
" =================================
" Load vim-sensible defaults so that settings below can override them
runtime! plugin/sensible.vim

set cursorline

set number
set relativenumber

set hidden
set clipboard=unnamed

set ignorecase
set smartcase
set termguicolors

" do not inserts comments automatically on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Mappings

" }}}

" Theme {{{
" =================================
" Tokyo Night settings
" The theme comes in two styles, 'storm' and a darker variant 'night'.
let g:tokyonight_style = "night"

" Comments are italicized by default
let g:tokyonight_italic_comments = 1

" Keywords are italicized by default
let g:tokyonight_italic_keywords = 1

" Functions are not italicized by default
let g:tokyonight_italic_functions = 0

" Enable this to disable setting the background color
let g:tokyonight_transparent = 0

" Enabling this option, will hide inactive statuslines and
" replace them with a thin border instead. Should work with
" the standard `StatusLine` and `LuaLine`.
let g:tokyonight_hide_inactive_statusline = 0

colorscheme onenord

" }}}

" Plugin settings

" gitsigns.nvim {{{

lua require('gitsigns').setup()

" }}}

" nvim-treesitter {{{

lua <<EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = { "javascript", "css", "vim", "lua", "c", "cpp"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
  autotag = {
    enable = true,
  }
}
EOF
" }}}

" nvim-lspconfig {{{
lua <<EOF

-- rust-analyzer
require'lspconfig'.rust_analyzer.setup{}

-- tsserver
require'lspconfig'.tsserver.setup{}

-- vimls
require'lspconfig'.vimls.setup{}

-- svelte
require'lspconfig'.svelte.setup{}

-- clangd
require'lspconfig'.clangd.setup{}

-- cssls
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

EOF

" }}}

" autopairs {{{
lua require('nvim-autopairs').setup{}
" }}}

" nvim-cmp {{{

set completeopt=menu,menuone,noselect

lua <<EOF

 -- Setup nvim-cmp.
 local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
    }
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
    }


require'cmp'.setup {
  sources = {
    { name = 'nvim_lsp' }
  }
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- lspkind
local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({with_text = false, maxwidth = 50})
  }
}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

EOF

" }}}

" nvim-lualine {{{
lua <<EOF

require('lualine').setup()

EOF

" }}}

" nvim-tree {{{
lua <<EOF

-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}
EOF

" }}}

" formatter.nvim {{{
lua<<EOF
require('formatter').setup({
  filetype = {
    html = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
          stdin = true
        }
      end
    },
    javascript = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
          stdin = true
        }
      end
    },
    svelte = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
          stdin = true
        }

      end
    },
  }
})

EOF
" }}}

" colorizer {{{
lua require'colorizer'.setup()
" }}}

" svelte {{{

let g:vim_svelte_plugin_load_full_syntax = 1
let g:vim_svelte_plugin_use_typescript = 1

" }}}

" trouble.nvim {{{
lua << EOF
  require("trouble").setup {}
EOF
" }}}

" cokeline.nvim {{{

lua << EOF
local get_hex = require('cokeline/utils').get_hex

require('cokeline').setup({
  -- If true the bufferline is hidden when only one buffer is listed
  hide_when_one_buffer = false,

  -- Controls what happens when the first (last) buffer is focused and the user
  -- tries to focus/switch to the previous (next) buffer. If true the last
  -- (first) buffer gets focused/switched to, if false nothing happens.
  cycle_prev_next_mappings = false,

  buffers = {
    -- A function to filter out unwanted buffers. It takes the `buffer` table
    -- (described above) as a parameter.
    -- For example, if you want to keep terminals out of your cokeline:
    --   filter = function(buffer) return buffer.type ~= 'terminal' end,
    filter = nil,
  },

  -- Default colors for the foregound/background of focused/unfocused
  -- lines. Their default values are derived from the foreground/background of
  -- other highlight groups.
  default_hl = {
    focused = {
      fg = get_hex('ColorColumn', 'bg'),
      bg = get_hex('Normal', 'fg'),
    },
    unfocused = {
      fg = get_hex('Normal', 'fg'),
      bg = get_hex('ColorColumn', 'bg'),
    },
  },

  -- A list of components used to build every line of the cokeline.
  components = {
    {
      text = function(buffer) return ' ' .. buffer.devicon.icon end,
      hl = {
        fg = function(buffer) return buffer.devicon.color end,
      },
    },
    {
      text = function(buffer) return buffer.unique_prefix end,
      hl = {
        fg = get_hex('Comment', 'fg'),
        style = 'italic',
      },
    },
    {
      text = function(buffer) return buffer.filename .. ' ' end,
    },
    {
      text = ' ',
    }
  },
})

EOF

" }}}

" stabilize.nvim {{{
lua <<EOF
require("stabilize").setup()
EOF
" }}}

" lsp_signature.nvim {{{
lua <<EOF
require "lsp_signature".setup()
EOF
" }}}

" nvim context_commentstring {{{

lua <<EOF
require'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true
  }
}
EOF

" }}}

" Mappings

" general {{{

let mapleader = " "
nnoremap <leader>sv :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>ev :edit ~/.config/nvim/init.vim<CR>

nnoremap <M-s> :write<CR>
inoremap <M-s> <Esc>:write<CR>gi
nnoremap <M-q> :bd<CR>
nnoremap ; :

nnoremap <C-p> :Telescope find_files<CR>
nnoremap <leader>t :NvimTreeToggle<CR>

nmap <C-_> gcc
vmap <C-_> gc

nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pU :PlugUpgrade<CR>
nnoremap <leader>pu :PlugUpdate<CR>

" Easier navigation between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

  " centered cursor
  nnoremap n nzzzv
  nnoremap N Nzzzv
  nnoremap J mzJ`z
  
  " copy rest of line
  nnoremap Y y$

  " undo breakpoints
  inoremap , ,<c-g>u
  inoremap . .<c-g>u
  inoremap ! !<c-g>u
  inoremap ? ?<c-g>u

  " moving text
  vnoremap <A-j> :m '>+1<CR>gv=gv
  vnoremap <A-k> :m '<-2<CR>gv=gv
  inoremap <A-j> <Esc>:m .+1<CR>==gi
  inoremap <A-k> <Esc>:m .-2<CR>==gi
  nnoremap <A-j> :m .+1<CR>==
  nnoremap <A-k> :m .-2<CR>==

  inoremap <C-c> <esc>
" }}}

" formatter.nvim {{{ 

nnoremap <silent> <M-f> :Format<CR>

" }}}

" spectre {{{
nnoremap <leader>S :lua require('spectre').open()<CR>

"search current word
nnoremap <leader>sw :lua require('spectre').open_visual({select_word=true})<CR>
vnoremap <leader>s :lua require('spectre').open_visual()<CR>

"  search in current file
nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>

" }}}

" LSP {{{
nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
" nnoremap <leader>vsd :lua vim.lsp.diagnostic.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
" nnoremap <leader>vll :call LspLocationList()<CR>
" }}}

" Telescope {{{

" Find files using Telescope command-line sugar.
noremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope colorscheme<cr>
nnoremap <leader>fr <cmd>Telescope registers<cr>
nnoremap <leader>fm <cmd>Telescope man_pages<cr>

" }}}

" trouble.nvim {{{

" trouble.nvim {{{

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" }}}

" cokeline.nvim {{{

" Focus the previous/next buffer
nmap <silent> <leader>k <Plug>(cokeline-focus-prev)
nmap <silent> <leader>j <Plug>(cokeline-focus-next)

" Switch the position of the current buffer with the previous/next buffer
nmap <silent> <Leader>K <Plug>(cokeline-switch-prev)
nmap <silent> <Leader>J <Plug>(cokeline-switch-next) " }}}
