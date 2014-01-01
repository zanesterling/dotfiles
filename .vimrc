call pathogen#incubate()
call pathogen#helptags()

syntax on

set t_Co=256
set smartindent

set background=dark
let g:solarized_termcolors=256
let g:solarized_visibility=256
let g:solarized_contrast=256
colorscheme solarized

set nu

set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
