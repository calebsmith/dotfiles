set nocompatible
set autoread
set showmode
set showmatch
set mat=2
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set laststatus=2
set path=$PWD/**
set number
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set title
set ruler
syntax enable
set encoding=utf8
set ffs=unix,dos,mac
set nobackup
set nowb
set noswapfile
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
set bg=dark
let python_highlight_all = 1
set nofoldenable

" Setting up Vundle - the vim plugin bundler
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
    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
    endif
" Setting up Vundle - the vim plugin bundler end

