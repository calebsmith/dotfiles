" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" General Override of Defaults
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Show the title, ruler, status, mode, and absolute line numbers
set showmode
set laststatus=2
set title
set ruler
set number
set hidden

" This is what files look like
set encoding=utf8
set ffs=unix,dos,mac
set wildignore=*.pyc,*.pyo,*.o,*.so,*.out

" From whence you came, you shall remain, until you set, the path again
set path=$PWD/**

" Tab sanity
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set backspace+=start,eol,indent

" Show hidden characters, tabs, trailing whitespace
set list
set listchars=tab:→\ ,trail:·,nbsp:·

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

" Highlight red for trailing white space
highlight WarnHighlight ctermbg=red guibg=red
highlight ColorColumn ctermbg=darkgrey guibg=darkgrey

autocmd BufWinEnter * match WarnHighlight /\s\+$/
autocmd InsertEnter * match WarnHighlight /\s\+\%#\@<!$/
autocmd InsertLeave * match WarnHighlight /\s\+$/
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

" Shortcuts
set pastetoggle=<F2>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Leader Configuration
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Define leader key
let mapleader = ","

" Define leader commands:

" See mappings
nnoremap <leader>? :map<cr>
" Make leader space clear search
nnoremap <leader><space> :noh<cr>
" Leaders for custom functions
nnoremap <leader>w :call StripTrailingWhitespaces()<cr>
nnoremap <leader>c :call ToggleColorColumn()<cr>
nnoremap <leader>F :call ToggleFold()<cr>
nnoremap <leader>f za
" Leaders for vim-dispatch
nnoremap <leader>m :Make!<cr>
nnoremap <leader>d :Dispatch<cr>
nnoremap <leader>o :Copen<cr>
" Leaders for tags
nnoremap <leader>tg :TagsGenerate<cr>
nnoremap <leader>j :tjump<space>
" Enable Zen Mode
nnoremap <Leader>z :LiteDFMToggle<CR>:silent !tmux set status > /dev/null 2>&1<CR>:redraw!<CR>

" Misc leaders
nnoremap <leader>i :BundleInstall<cr>
nnoremap <leader>s :exe "mksession! ~/.vim/.sessions/latest.vim"<cr>:w!<cr>
nnoremap <leader>l :exe "source ~/.vim/.sessions/latest.vim"<cr>
nnoremap <leader>r :source ~/.vimrc<cr>

nnoremap <leader>e :LustyFilesystemExplorer<cr>
nnoremap <leader>eh :LustyFilesystemExplorerFromHere<cr>
nnoremap <leader>b :LustyBufferExplorer<cr>
nnoremap <leader>g :LustyBufferGrep<cr>


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Plugin Installation
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
    Bundle 'Valloric/YouCompleteMe'
    Bundle 'szw/vim-tags'
    Bundle 'tpope/vim-dispatch'
    Bundle 'amdt/vim-niji'
    Bundle 'pfdevilliers/Pretty-Vim-Python'
    Bundle 'bilalq/lite-dfm'
    Bundle 'sjbach/lusty'
    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
    endif
" end of vundle setup

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Plugin Configuration
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Syntastic Configuration
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_c_checkers = ['splint']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_aggregate_errors = 1

" YCM Configuration
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" vim-tags Configuration
let g:vim_tags_use_ycm = 1

" Dispatch Configuration
autocmd FileType erlang let b:dispatch = 'erl -make'

" LiteDFM Configuration
let g:lite_dfm_normal_bg_cterm = 234
let g:lite_dfm_left_offset = 4

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

" Folding
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" A function to quickly toggle folding and unfolding everything
function! ToggleFold()
    if !exists("g:code_is_folded")
        let g:code_is_folded = 0
    endif
    if g:code_is_folded == 1
        set foldlevel=30
        let g:code_is_folded = 0
    else
        set foldlevel=0
        let g:code_is_folded = 1
    endif
endfunction

" Color Column
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" A function to toggle colorcolumn on and off
function! ToggleColorColumn()
    if g:show_column_toggle == 1
        set colorcolumn=0
        let g:show_column_toggle = 0
    else
        set colorcolumn=80,110
        let g:show_column_toggle = 1
    endif
endfunction
if !exists("g:show_column_toggle")
    let g:show_column_toggle = 0
    call ToggleColorColumn()
endif
