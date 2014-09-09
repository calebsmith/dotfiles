SHELL = /bin/bash

.PHONY: all tmux git vim indent xmonad

all:
	make tmux
	make git
	make vim
	make indent
	make xmonad

tmux:
	@(source ./safe_copy.sh; \
	safe_copy tmux/tmux.conf ~/.tmux.conf; \
	[ $$safe_copy_result -ne 0 ] || tmux source-file ~/.tmux.conf)

git:
	@(source ./safe_copy.sh; \
	safe_copy git/gitconfig ~/.gitconfig && \
	safe_copy git/gitignore ~/.gitignore)

vim:
	@(source ./safe_copy.sh; \
	safe_copy vim/vimrc ~/.vimrc)

indent:
	@(source ./safe_copy.sh; \
	safe_copy indent/indent.pro ~/.indent.pro)

xmonad:
	@(source ./safe_copy.sh; \
	safe_copy xmonad/xmobarrc ~/.xmobarrc; \
	[ $$safe_copy_result -ne 0 ] || xmonad --recompile; \
	safe_copy xmonad/xmonad.hs ~/.xmonad/xmonad.hs; \
	[ $$safe_copy_result -ne 0 ] || xmonad --recompile)
