" Vundle
filetype off
call plug#begin()
  " Core
  Plug 'vim-airline/vim-airline'
  Plug 'vimwiki/vimwiki'
  Plug 'mattn/calendar-vim'

  " Highlighting
  Plug 'rust-lang/rust.vim'
  Plug 'lepture/vim-jinja'
  "Plug 'LaTeX-Suite-aka-Vim-LaTeX'
  Plug 'dracula/vim', { 'as': 'dracula' }

  Plug 'tpope/vim-dispatch'

  Plug 'tpope/vim-surround'
call plug#end()
filetype plugin on


" Global defaults
set t_Co=256
set nocompatible
set number
set relativenumber
set backspace=indent,eol,start
syntax on

set noexpandtab
set autoindent
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4

set re=2 " NFA-based regex engine, should be faster than default.


" Colorscheme
silent! colorscheme dracula


" ???
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"


" Filetype settings
au BufRead,BufNewFile *.scm  setlocal ts=2 sw=2
au BufRead,BufNewFile *.html setlocal ts=2 sw=2 expandtab
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja
au BufNewFile,BufRead *.inc  set ft=asm
au BufNewFile,BufRead *.txt  set ft=text
au BufNewFile,BufRead *.wiki set ft=vimwiki
au! FileType asm     setl ft=nasm expandtab
au! FileType python  setl ts=4 sw=4 expandtab
au! FileType c       setl ts=4 sw=4 expandtab
au! Filetype text    setl textwidth=79
au! FileType vimwiki setl textwidth=79 expandtab
au! Filetype haskell setl ts=2 sw=2 et sts=2
au BufNewFile,BufRead *.cabal setl ts=2 sw=2 et sts=2


" Relative line number toggling
function! NumberToggle()
  if(&relativenumber == 1)
    set relativenumber!
    set number
  else
    set relativenumber
    set number!
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>


" Toggle search highlighting with <Space>
nnoremap <Space> :nohlsearch<cr>
set hlsearch


" Airline customization
set laststatus=2
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='dark'


" Vimwiki customization
let g:vimwiki_folding='list'
let g:vimwiki_list=[{
  \ 'path': '$HOME/vimwiki',
  \ 'path_html': '$HOME/vimwiki/html',
  \ 'template_path': '$HOME/vimwiki/templates',
  \ 'template_default': 'default',
  \ 'template_ext': '.html' }]


" Latex customization
set grepprg=grep\ -nH\ $*
let g:latex_flavor='latex'
let g:Tex_TreatMacViewerAsUNIX = 1
let g:Tex_ExecuteUNIXViewerInForeground = 1
let g:Tex_ViewRule_pdf='open -a Preview'
let s:viewer='open'


" Folding customization
function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()
set foldlevelstart=20
let g:rust_fold=1
