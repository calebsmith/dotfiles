SHELL = /bin/bash

.PHONY: all bin tmux git vim indent xmonad lein spacemacs

all:
	make bin
	make tmux
	make git
	make vim
	make indent
	make xmonad
	make lein
	make spacemacs
	make i3

bin:
	@(source ./safe_copy.sh; \
	safe_copy bin/tmuxinator.bash ~/bin/tmuxinator.bash && \
	safe_copy bin/tidalboot ~/bin/tidalboot && \
	safe_copy bin/BootTidal.hss ~/bin/BootTidal.hss && \
	safe_copy bin/sicp-racket ~/bin/sicp-racket && \
	safe_copy bin/scmindent.rkt ~/bin/scmindent.rkt && \
	safe_copy bin/android_helpers.sh ~/bin/android_helpers.sh && \
	safe_copy bin/npm-completion.sh ~/bin/npm-completion.sh && \
	safe_copy bin/git-completion.sh ~/bin/git-completion.sh && \
	safe_copy bin/env_helper.sh ~/bin/env_helper.sh)


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
	safe_copy vim/vimrc ~/.config/nvim/init.vim && \
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

lein:
	@(source ./safe_copy.sh; \
	safe_copy lein/profiles.clj ~/.lein/profiles.clj)

spacemacs:
	@(source ./safe_copy.sh; \
	safe_copy spacemacs/spacemacs ~/.spacemacs)

i3:
	@(source ./safe_copy.sh; \
	safe_copy i3/config ~/.config/i3/config)
	i3-msg reload
