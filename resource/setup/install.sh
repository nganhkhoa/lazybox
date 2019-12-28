if [ $# -eq 0 ]; then
    AUR_USER='root'
else
    AUR_USER=$1
fi

if [ $AUR_USER == 'root' ]; then
    WORKSPACE='/root'
else
    WORKSPACE=/home/$AUR_USER
fi

cp -r /root/resource/config/* $WORKSPACE/.config
cp /root/resource/home/bashrc $WORKSPACE/.bashrc
cp /root/resource/home/bowerrc $WORKSPACE/.bowerrc
cp /root/resource/setup/init.sh $WORKSPACE

pacman -Suy --noconfirm \
  git make cmake neovim vim openssh netcat iputils iproute2 wget curl ripgrep fzf gdb bat exa diff-so-fancy httpie \
  p7zip unrar unzip zip unarchiver bzip2 gzip lrzip lz4 lzip lzop xz tar \
  texlive-core texlive-lang \
  radare2 \
  gcc \
  python python-pip python2 python2-pip sagemath \
  jre8-openjdk-headless jdk8-openjdk \
  nodejs yarn \
  crystal ruby \
  go rust elixir stack sbt

# for haskell-stack and purescript
su $AUR_USER -c 'yay -S --needed --noprogressbar --needed --noconfirm ncurses5-compat-libs'
# for tex packages
su $AUR_USER -c 'yay -S --needed --noprogressbar --needed --noconfirm texlive-localmanager-git'

mkdir -p $WORKSPACE/bin
mkdir -p $WORKSPACE/tools
mkdir -p $WORKSPACE/workspace  # maps to User/$USER/
mkdir -p $WORKSPACE/desktop    # maps to User/$USER/Desktop, for quick jump
mkdir -p $WORKSPACE/drive      # in here have mapping to disk drives

# volatility
git clone https://github.com/volatilityfoundation/volatility.git $WORKSPACE/tools/volatility
pip2 install distorm3
pip2 install $WORKSPACE/tools/volatility

# quick unpack archive and put them in folders too
# git clone https://github.com/mitsuhiko/unp.git /root/tools/unp
# pip install /root/tools/unp
pip install unp

# nodejs based programming languages
yarn global add coffeescript typescript ts-node bs-platform purescript
# frequently use nodejs modules
yarn global add express koa ramda lodash react create-react-app pulp bower spago

# python based programming languages
pip install coconut
# frequently use python modules
sage -python2 -m pip install pwntools PyCryptodome z3-solver
pip2 install pwntools PyCryptodome z3-solver numpy
pip install ipython PyCryptodome z3-solver numpy

# frequently use ruby modules
gem install bundler jekyll

# exercism
curl -s https://api.github.com/repos/exercism/cli/releases/latest \
  | grep "linux-x86_64.tar.gz" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -O $WORKSPACE/tools/exercism.tar.gz -qi -
mkdir -p $WORKSPACE/tools/exercism
tar -xzvf $WORKSPACE/tools/exercism.tar.gz -C $WORKSPACE/tools/exercism

# make all file own to user
chown -R $AUR_USER:$AUR_USER $WORKSPACE

echo "Setup arch completed"
