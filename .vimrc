" Helps force plugins to load correctly when it is turned back on below
filetype off
filetype plugin indent on

syntax on               " Syntax highlighting

" vim-plug plugins
call plug#begin("~/.vim/plugged")
    Plug 'Valloric/YouCompleteMe'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'ayu-theme/ayu-vim'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'Yggdroot/indentline'
    Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

" General
runtime macros/matchit.vim
set backspace=indent,eol,start  " Proper backspace behavior
set wildmenu            " Command-line completion
set showcmd             " Show (partial) command at bottom of screen
set mouse=a             " Enable using mouse

set number              " Show line number
set ruler               " Show line and col num of cursor pos
set showmatch           " Highlight matching brace

set shiftwidth=4        " Number of auto indent spaces
set softtabstop=4       " Num spaces per tab
set tabstop=4
set expandtab           " Insert softtabstop num of spaces
set smarttab            " Enable smart tabs

set autoindent          " Copy indentation from prev line
set colorcolumn=80,120  " Show screen columns
set nowrap              " Don't wrap on load
set formatoptions-=t    " Don't wrap when typing

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
noremap <C-l> :nohl<CR><C-l>

" Status line
set statusline+=%F

" Editor colors
set termguicolors       " Enable true colors support
let ayucolor="dark"
colorscheme ayu

" Display whitespace
set list
set listchars=tab:→\ ,nbsp:␣,trail:·,extends:⟩,precedes:⟨

" Cursor shape
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" IndentLine options
let g:indentLine_setColors = 0

" Ctrl-P options
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" vim-cpp-enhanced-highlight option
let g:cpp_class_scope_highlight = 1         " Highlight class scope
let g:cpp_member_variable_highlight = 1     " Highlight member variables
let g:cpp_class_decl_highlight = 1          " Highlight class names in declarations

" Custom commands
function! SetTabSize(n) abort
    execute "set shiftwidth=" . a:n
    execute "set softtabstop=" . a:n
    execute "set tabstop=" . a:n
endfunction
command! -nargs=1 Tab call SetTabSize(<f-args>)

function! TrimWhitespace() abort
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction
command! Trim call TrimWhitespace()
