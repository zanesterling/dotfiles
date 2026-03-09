set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin()
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	Plug 'neovim/nvim-lspconfig'

	" Telescope & dependencies
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'

	Plug 'elentok/format-on-save.nvim'

	" FZF, the fuzzy finder utility.
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

	" Fugitive, the git plugin.
	Plug 'tpope/vim-fugitive'

	" goto-preview, for previewing gotodef in floating windows
	Plug 'rmagatti/goto-preview'
call plug#end()


lua require('config/treesitter')
lua require('config/lsp')
lua require('config/telescope')

nnoremap <leader>f <cmd>Files<CR>
nnoremap <leader>b <cmd>Buffers<CR>
nnoremap <leader>r <cmd>RG<CR>
nnoremap <leader>w <cmd>Windows<CR>

" This is required to make it so that the omnithingy doesn't also pop up a
" preview buffer+window that sticks around after you're done.
"
" The default setting is `=menu,preview`.
"
" source: github.com/fatih/vim-go/issues/223#issuecomment-62619901
set completeopt=menu

lua require('config/goto_preview')
nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap gpt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap gpD <cmd>lua require('goto-preview').goto_preview_declaration()<CR>
nnoremap gP  <cmd>lua require('goto-preview').close_all_win()<CR>
nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>

" Enable loading of plugin files for specific file types.
" These are loaded from ftplugin/FILETYPE.lua,
" eg. ftplugin/html.lua.
filetype plugin on

" Make searching case-insensitive by default.
set ignorecase
" Make searching case-sensitive if the search pattern contains an uppercase
" character.
set smartcase

" When you open a file in a new split with ":vs FILENAME", open the new file
" in the right side of the split.
set splitright

command Nvfix tabnew ~/.config/nvim/init.vim
command Nvrld source ~/.config/nvim/init.vim
nnoremap <leader>[ <cmd>Nvfix<CR>
nnoremap <leader>] <cmd>Nvrld<CR>

autocmd BufRead,BufNewFile METADATA   setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.ts,*.tsx setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.sql      setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.yaml     setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.css      setlocal ts=2 sw=2 expandtab

" If in one of foo/blah{.ts,.ng.html,_test.ts},
" opens foo/blah.ts, foo/blah_test.ts, and foo/blah.ng.html in tabs.
command AngTabset e %:r:r:s?_test$??.ts | tabnew %:r:r.ng.html | tabnew %:r:r_test.ts | tabm -1

" Go to last active tab 
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>

nnoremap <c-w>t <cmd>tab split<CR>
