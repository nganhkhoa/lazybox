FROM archlinux/base:latest

# it is very weird that neovim and vim cannot install
RUN pacman -Suy --noconfirm \
  git cmake neovim vim openssh netcat \
  gcc gdb \
  python python-pip python2 python2-pip sagemath \
  crystal elixir ruby nodejs yarn go rust \
  radare2

RUN \
  sage -python2 -m pip install pwntools PyCryptodome z3-solver && \
  pip2 install pwntools && \
  pip2 install PyCryptodome z3-solver && \
  pip install PyCryptodome z3-solver

# COPY setup script .bashrc .vimrc
