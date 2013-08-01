all:
	make tmux
	make git
	make vim
	make indent

tmux:
	cp .tmux.conf ~

git:
	cp .gitconfig ~

vim:
	cp .vimrc ~
indent:
	cp .indent.pro ~
