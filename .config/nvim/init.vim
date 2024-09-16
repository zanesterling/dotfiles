set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin()
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-treesitter/playground'

	Plug 'neovim/nvim-lspconfig'

	" Telescope & dependencies
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }

	Plug 'elentok/format-on-save.nvim'
call plug#end()


" Treesitter stuff.
lua require('config/treesitter')
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

lua require('config/lsp')
lua require('config/telescope')

" This is required to make it so that the omnithingy doesn't also pop up a
" preview buffer+window that sticks around after you're done.
"
" The default setting is `=menu,preview`.
"
" source: github.com/fatih/vim-go/issues/223#issuecomment-62619901
set completeopt=menu

lua require('config/format_on_save')

" Enable loading of plugin files for specific file types.
" These are loaded from ftplugin/FILETYPE.lua,
" eg. ftplugin/html.lua.
filetype plugin on

" Make searching case-insensitive by default.
set ignorecase
" Make searching case-sensitive if the search pattern contains an uppercase
" character.
set smartcase

command Nvfix tabnew ~/.config/nvim/init.vim
command Nvrld source ~/.config/nvim/init.vim
autocmd BufRead,BufNewFile METADATA setlocal ts=2 sw=2 expandtab

" If in one of foo/blah{.ts,.ng.html,_test.ts},
" opens foo/blah.ts, foo/blah_test.ts, and foo/blah.ng.html in tabs.
command AngTabset e %:r:r:s?_test$??.ts | tabnew %:r:r.ng.html | tabnew %:r:r_test.ts | tabm -1
