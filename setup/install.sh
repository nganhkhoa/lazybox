pacman -Suy --noconfirm \
  git make cmake neovim vim openssh netcat iputils wget curl ripgrep fzf gcc gdb bat exa diff-so-fancy \
  p7zip unrar unzip zip unarchiver bzip2 gzip lrzip lz4 lzip lzop xz tar \
  radare2 \
  python python-pip python2 python2-pip sagemath \
  jre8-openjdk-headless jdk8-openjdk \
  nodejs yarn \
  crystal ruby \
  go rust elixir

mkdir -p /root/bin
mkdir -p /root/tools
mkdir -p /root/workspace  # maps to User/$USER/
mkdir -p /root/desktop    # maps to User/$USER/Desktop, for quick jump
mkdir -p /root/drive      # in here have mapping to disk drives

# for quick aur install
echo "su docker -c 'yay -S --needed --noprogressbar --needed --noconfirm '\$@" > /root/bin/aur.sh
chmod +x /root/bin/aur.sh

sage -python2 -m pip install pwntools PyCryptodome z3-solver
pip2 install pwntools PyCryptodome z3-solver
pip install ipython PyCryptodome z3-solver

# volatility
git clone https://github.com/volatilityfoundation/volatility.git /root/tools/volatility
pip2 install distorm3
pip2 install /root/tools/volatility

# quick unpack archive and put them in folders too
git clone https://github.com/mitsuhiko/unp.git /root/tools/unp
pip install /root/tools/unp

# neovim setup
curl -fLo /root/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip install pynvim

echo "Setup arch completed"