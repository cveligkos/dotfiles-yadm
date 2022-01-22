" vim:fdm=marker

" general {{{

let mapleader = " "
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ev :edit $MYVIMRC<CR>

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
nnoremap <leader>fkm <cmd>Telescope keymaps<cr>
nnoremap <leader>R <cmd>Telescope resume<cr>

" }}}

" trouble.nvim {{{

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" }}}

" rnvimr {{{

nnoremap <silent> <M-o> :RnvimrToggle<CR>

"}}}

" nvim-hlslens {{{

noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap * *<Cmd>lua require('hlslens').start()<CR>
noremap # #<Cmd>lua require('hlslens').start()<CR>
noremap g* g*<Cmd>lua require('hlslens').start()<CR>
noremap g# g#<Cmd>lua require('hlslens').start()<CR>

" use : instead of <Cmd>
nnoremap <silent> <leader>l :noh<CR>

" }}}
