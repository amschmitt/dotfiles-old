"Plugins

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'vimwiki/vimwiki'
Plug 'alcesleo/vim-uppercase-sql'
Plug 'mattn/calendar-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

"Define

let g:vimwiki_list = [{
    \ 'path': '~/Documents/Tier\ 3/',
    \ 'path_html': '~/Documents/Tier\ 3/',
    \ }]

"Keybindings

nmap gj i<CR><Esc>
nmap gl i<Tab><Esc>

cmap w!! w !sudo tee % > /dev/null

"Settings

set number
set shiftwidth=4
set smarttab
set softtabstop=4
set expandtab
set autoindent
set smartindent
set autoread
set ignorecase
set showmatch
set foldmethod=syntax
set foldlevel=99
set encoding=utf-8

if !exists('g:syntax_on')
    syntax enable
endif

set cursorline
highlight CursorLine ctermbg=black
set t_Co=256
set background=dark
colorscheme gruvbox

"Setup calendar/vimwiki integration

au BufRead,BufNewFile *.wiki set filetype=vimwiki
:autocmd FileType vimwiki map wd :VimwikiMakeDiaryNote
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
endfunction
    
:autocmd FileType vimwiki map wc :call ToggleCalendar()<CR>

"Snippets config

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


"External links or something (copied from Kyle's Vimrc)

function! VimwikiLinkHandler(link)
    " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
    "   1) [[vfile:~/Code/PythonProject/abc123.py]]
    "   2) [[vfile:./|Wiki Home]]
    let l:link = a:link
    if l:link =~# '^vfile:'
        let l:link = l:link[1:]
    else
        return 0
    endif
    let l:link_infos = vimwiki#base#resolve_link(l:link)
    if l:link_infos.filename ==# ''
        echomsg 'Vimwiki Error: Unable to resolve link!'
        return 0
    else
        exe 'tabnew ' . fnameescape(l:link_infos.filename)
        return 1
    endif
endfunction
