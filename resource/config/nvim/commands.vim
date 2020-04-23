if has('unix')
  command! EditVimrc :e ~/.config/nvim/init.vim
else
  command! EditVimrc :e ~/AppData/Local/nvim/init.vim
endif
