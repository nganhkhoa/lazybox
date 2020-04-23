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

mkdir -p $WORKSPACE/.stack
cp -r /lazybox/resource/config/* $WORKSPACE/.config
cp /lazybox/resource/home/bashrc $WORKSPACE/.bashrc
cp /lazybox/resource/home/bowerrc $WORKSPACE/.bowerrc
cp /lazybox/resource/home/stack.yaml $WORKSPACE/.stack/config.yaml
cp /lazybox/resource/setup/init.sh $WORKSPACE

pacman -Suy --noconfirm \
  git make cmake neovim vim openssh netcat iputils iproute2 wget curl ripgrep fzf gdb bat exa diff-so-fancy httpie \
  p7zip unrar unzip zip unarchiver bzip2 gzip lrzip lz4 lzip lzop xz tar \
  texlive-core texlive-lang \
  radare2 \
  gcc clang \
  python python-pip python2 python2-pip sagemath \
  nodejs yarn \
  crystal ruby \
  go rust elixir stack sbt sbcl clojure rlwrap
  # jre/jdk 13 --- will be installed by leiningen below

# haskell-stack and purescript
# - ncurses5-compat-libs
# clojure
# - leiningen
# |- jre/jdk 13
# tex packages
# - texlive-localmanager-git
su $AUR_USER -c 'yay -S --needed --noprogressbar --needed --noconfirm ncurses5-compat-libs leiningen texlive-localmanager-git'

mkdir -p $WORKSPACE/bin
mkdir -p $WORKSPACE/tools
mkdir -p $WORKSPACE/workspace  # maps to User/$USER/
mkdir -p $WORKSPACE/desktop    # maps to User/$USER/Desktop, for quick jump
mkdir -p $WORKSPACE/drive      # mapping to disk drives

#################################################################################################################################

mkdir -p $WORKSPACE/tools/yafu
wget -O $WORKSPACE/tools/yafu/yafu.zip https://nchc.dl.sourceforge.net/project/yafu/1.34/yafu-1.34.zip
unzip $WORKSPACE/tools/yafu/yafu.zip -d $WORKSPACE/tools/yafu
cp $WORKSPACE/tools/yafu/yafu $WORKSPACE/bin
# sage -python2 -m pip install pwntools PyCryptodome z3-solver
sage -python -m pip install pwntools PyCryptodome z3-solver # sage is now python3

yarn global add coffeescript typescript ts-node bs-platform purescript \
  express koa ramda lodash react create-react-app pulp bower spago

# frequently use ruby modules
gem install bundler jekyll

# volatility
git clone https://github.com/volatilityfoundation/volatility.git $WORKSPACE/tools/volatility
# install will be in user space, moved to init.sh

# apktool
mkdir -p $WORKSPACE/tools/apktool
wget -O $WORKSPACE/tools/apktool/apktool https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool
chmod +x $WORKSPACE/tools/apktool/apktool
# TODO: dynamically get apktool version
wget -O $WORKSPACE/tools/apktool/apktool.jar https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.4.1.jar
chmod +x $WORKSPACE/tools/apktool/apktool.jar # ???
cp $WORKSPACE/tools/apktool/* $WORKSPACE/bin
# jadx
git clone https://github.com/skylot/jadx $WORKSPACE/tools/jadx
$WORKSPACE/tools/jadx/gradlew dist
cp $WORKSPACE/tools/jadx/build/jadx/bin/jadx $WORKSPACE/bin

# getac
git clone https://github.com/fukamachi/getac $WORKSPACE/tools/getac
make --directory=$WORKSPACE/tools/getac
cp $WORKSPACE/tools/getac/bin/getac $WORKSPACE/bin

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
