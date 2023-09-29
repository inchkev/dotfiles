" Helps force plugins to load correctly when it is turned back on below
filetype off
filetype plugin indent on

" Enable syntax highlighting
syntax on
let mapleader = " "

" vim-plug plugins
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.3' }

    Plug 'neovim/nvim-lspconfig'

    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    " Plug 'Yggdroot/indentline'

    Plug 'lukas-reineke/indent-blankline.nvim'

    " TypeScript
    Plug 'jose-elias-alvarez/typescript.nvim'

    " Node
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " TreeSitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Plug 'ayu-theme/ayu-vim'
    Plug 'morhetz/gruvbox'
call plug#end()

let g:ycm_show_diagnostics_ui = 0

" General
runtime macros/matchit.vim
set backspace=indent,eol,start  " Proper backspace behavior
set wildmenu            " Command-line completion
set showcmd             " Show (partial) command at bottom of screen
set mouse+=a            " Enable using mouse
" if has("mouse_sgr")
"     set ttymouse=sgr
" else
"     set ttymouse=xterm2
" end

set number              " Show line number
set rnu                 " Show relative line number
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
let g:gruvbox_contrast_dark = "medium"
let g:gruvbox_contrast_light = "medium"
" let g:gruvbox_italicize_strings=1
let g:gruvbox_invert_selection=1
colorscheme gruvbox

" Display whitespace
set list
set listchars=tab:→\ ,nbsp:␣,trail:·,extends:⟩,precedes:⟨

" IndentLine options
lua require("indent_blankline").setup({show_current_context = true})

" Telescope options
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Highlight .ejs files as .html
au BufNewFile,BufRead *.ejs set filetype=html

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

" netrw configs
let g:netrw_banner = 0
let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 12
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

" typescript configs
lua require("typescript").setup({disable_commands=false})

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
