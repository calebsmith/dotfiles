" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Override of Defaults
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Show the title, ruler, status, and mode
set showmode
set laststatus=2
set title
set ruler

" Use 'hybrid' mode for line numbers
set relativenumber
set number

" This is what files look like
set encoding=utf8
set ffs=unix,dos,mac

" From whence you came, you shall remain, until you set, the path again
set path=$PWD/**

" Tab sanity
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set backspace+=start,eol,indent

" Alas Master Wq, Master Git's wushu is greater
" (I don't really need this backup or swapfile stuff thanks to DVC)
set autoread
set nobackup
set nowb
set noswapfile

" Keep lots of history/undo
set history=1000
set undolevels=1000

" Use filetype in lieu of compatible if available
if has("autocmd")
    filetype on
    filetype indent on
    filetype plugin on
    set nocompatible
endif

" Syntax highlighting
syntax enable

" Enable folding but leave it unfolded by default
set foldmethod=indent
set foldlevel=30
" Fold commands
" zR    open all folds
" zM    close all folds
" za    toggle fold at cursor position
" zj    move down to start of next fold
" zk    move up to end of previous fold


" Highlight red for trailing white space after insert or for line too long
highlight ExtraWhitespace ctermbg=red guibg=red

autocmd BufWinEnter * match ExtraWhitespace /\s\+$\|\%80v.\+/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$\|\%80v.\+/
autocmd InsertLeave * match ExtraWhitespace /\s\+$\|\%80v.\+/
autocmd BufWinLeave * call clearmatches()

" Make the background dark and the foreground colorful
set bg=dark
set t_Co=256

" Highlight search, show the matches as the search term is typed, and
" highlight matching punctuation
set hlsearch
set incsearch
set mat=2
set showmatch

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Key Mappings
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Pretend arrow keys don't exist - (No cheating!)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>

" Put escape on the home row
inoremap jk <esc>
inoremap kj <esc>

" Define leader key
let mapleader = ","

" Define leader commands:
"   Make leader space clear search
nnoremap <leader><space> :noh<cr>
nnoremap <leader>w :call StripTrailingWhitespaces()<cr>


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Plugin Bootstrap and Configuration
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Set up Vundle on first install - Vundle, in turn, installs all other plugins
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    "List bundles here
    Bundle 'gmarik/vundle'
    Bundle 'scrooloose/syntastic'
    Bundle 'pfdevilliers/Pretty-Vim-Python'
    Bundle 'Valloric/YouCompleteMe'
    Bundle 'szw/vim-tags'
    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
    endif
" end of vundle setup

" Syntastic Configuration
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_c_checkers = ['splint']

" YCM Configuration
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" vim-tags Configuration
let g:vim_tags_use_ycm = 1


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Custom Functions
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Whitespace
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" A function to strip trailing whitespace and clean up afterwards so
" that the search history remains intact and cursor does not move.
" Taken from: http://vimcasts.org/episodes/tidying-whitespace
" Taken in turn from: https://github.com/nrb/dotfiles/blob/master/.vimrc
function! StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
