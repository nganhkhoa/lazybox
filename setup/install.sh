pacman -Suy --noconfirm \
  git make cmake neovim vim openssh netcat iputils iproute2 wget curl ripgrep fzf gdb bat exa diff-so-fancy \
  p7zip unrar unzip zip unarchiver bzip2 gzip lrzip lz4 lzip lzop xz tar \
  radare2 \
  texlive-core texlive-lang \
  gcc \
  python python-pip python2 python2-pip sagemath \
  jre8-openjdk-headless jdk8-openjdk \
  nodejs yarn \
  crystal ruby \
  go rust elixir stack sbt

mkdir -p /root/bin
mkdir -p /root/tools
mkdir -p /root/workspace  # maps to User/$USER/
mkdir -p /root/desktop    # maps to User/$USER/Desktop, for quick jump
mkdir -p /root/drive      # in here have mapping to disk drives

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

# nodejs based programming languages
yarn global add coffeescript typescript ts-node bs-platform
# frequently use nodejs modules
yarn global add express koa ramda lodash react

# python based programming languages
pip install coconut
# frequently use python modules
sage -python2 -m pip install pwntools PyCryptodome z3-solver
pip2 install pwntools PyCryptodome z3-solver numpy
pip install ipython PyCryptodome z3-solver numpy

# purescript
curl -s https://api.github.com/repos/purescript/purescript/releases/latest \
  | grep "linux64.tar.gz" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -O /root/tools/purescript.tar.gz -qi -
tar -xzvf /root/tools/purescript.tar.gz -C /root/tools
su docker -c 'yay -S --needed --noprogressbar --needed --noconfirm ncurses5-compat-libs'
yarn global add pulp bower

# exercism
curl -s https://api.github.com/repos/exercism/cli/releases/latest \
  | grep "linux-x86_64.tar.gz" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -O /root/tools/exercism.tar.gz -qi -
mkdir -p /root/tools/exercism
tar -xzvf /root/tools/exercism.tar.gz -C /root/tools/exercism

echo "Setup arch completed"