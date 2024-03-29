" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'

  " Core
  Plugin 'vim-airline/vim-airline'
  Plugin 'vimwiki/vimwiki'
  Plugin 'mattn/calendar-vim'

  " Highlighting
  Plugin 'rust-lang/rust.vim'
  Plugin 'lepture/vim-jinja'
  "Plugin 'LaTeX-Suite-aka-Vim-LaTeX'
  Plugin 'dracula/vim' { 'name': 'dracula' }

  Plugin 'tpope/vim-dispatch'

  Plugin 'tpope/vim-surround'
call vundle#end()
filetype plugin on


" Global defaults
set t_Co=256
set nocompatible
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
au! FileType c       setl ts=4 sw=4 noexpandtab
au! Filetype text    setl textwidth=79
au! FileType vimwiki setl textwidth=79 expandtab
au! Filetype haskell setl ts=2 sw=2 et sts=2
au BufNewFile,BufRead *.cabal setl ts=2 sw=2 et sts=2


" Relative line number toggling
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

" Vimwiki-calendar integration
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
  if g:calendar_open == 1
    execute "q"
    unlet g:calendar_open
  else
    g:calendar_open = 1
  end
  else
    let g:calendar_open = 1
  end

  if exists("g:calendar_open") && g:calendar_open == 1
    setlocal nornu
    setlocal nonu
  end
endfunction
:autocmd FileType vimwiki map <leader>d :VimwikiMakeDiaryNote<cr>
:autocmd FileType vimwiki map <leader>cc :call ToggleCalendar()<cr>

" Vimwiki auto commit and push
let g:_vw = get(g:vimwiki_list, 0)
:autocmd BufWritePost *.wiki execute ':Start! $HOME/dotfiles/scripts/vimwiki-add.sh '  . g:_vw.path
:autocmd QuitPre      *.wiki execute ':!      $HOME/dotfiles/scripts/vimwiki-push.sh ' . g:_vw.path


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
