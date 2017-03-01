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

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

let CoVim_default_name = "zane"

" set settings based on filetype
au BufRead,BufNewFile *.scm setlocal ts=2 sw=2
au BufRead,BufNewFile *.html setlocal ts=2 sw=2 expandtab
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja
au BufNewFile,BufRead *.inc set ft=asm
au BufNewFile,BufRead *.txt set filetype=text
au BufNewFile,BufRead *.wiki set filetype=vimwiki
au! FileType asm setl ft=nasm expandtab
au! FileType python setl nosmartindent ts=4 sw=4
au! FileType c setl noexpandtab ts=4 sw=4
au! Filetype text setl textwidth=79
au! FileType vimwiki setl textwidth=79 expandtab

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

" vimwiki config
let g:vimwiki_folding='list'
let g:vimwiki_list=[{
	\ 'path': '$HOME/vimwiki',
	\ 'path_html': '$HOME/vimwiki/html',
	\ 'template_path': '$HOME/vimwiki/templates',
	\ 'template_default': 'default',
	\ 'template_ext': '.html' }]

" latex config
set grepprg=grep\ -nH\ $*
let g:latex_flavor='latex'
let g:Tex_TreatMacViewerAsUNIX = 1
let g:Tex_ExecuteUNIXViewerInForeground = 1
let g:Tex_ViewRule_pdf='open -a Preview'
let s:viewer='open'

set relativenumber
set t_Co=256

set smartindent
set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4

set backspace=indent,eol,start

" custom folding
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


" Vimwiki calendar stuf
:autocmd FileType vimwiki map d :VimwikiMakeDiaryNote
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
:autocmd FileType vimwiki map c :call ToggleCalendar()
