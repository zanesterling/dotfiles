call pathogen#infect('bundle/{}')
call pathogen#helptags()

syntax on

" configure solarized
set background=dark
let g:solarized_termcolors=256
let g:solarized_visibility=256
let g:solarized_contrast=256
colorscheme solarized

set nocompatible
filetype plugin on

set relativenumber
set t_Co=256

set smartindent
set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

set backspace=indent,eol,start

let CoVim_default_name = "zane"

au BufRead,BufNewFile *.scm setlocal ts=2 sw=2

au BufRead,BufNewFile *.html setlocal ts=2 sw=2 expandtab
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja

function! NumberToggle()
  if(&relativenumber == 1)
    set rnu!
    set number
  else
    set nu!
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

nnoremap <Space> :nohlsearch<cr>
set hlsearch

" airline config
set laststatus=2
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='dark'

let g:vimwiki_folding='list'

au VimEnter * Obsession
au! FileType python setl nosmartindent
