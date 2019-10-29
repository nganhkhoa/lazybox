# nodejs based programming languages
yarn global add coffeescript typescript bs-platform
# frequently use nodejs modules
yarn global add express koa ramda lodash react

# purescript
curl -s https://api.github.com/repos/purescript/purescript/releases/latest \
  | grep "linux64.tar.gz" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -O /root/tools/purescript.tar.gz -qi -
tar -xzvf /root/tools/purescript.tar.gz -C /root/tools
/root/bin/aur.sh ncurses5-compat-libs
yarn global add pulp bower

# exercism
curl -s https://api.github.com/repos/exercism/cli/releases/latest \
  | grep "linux-x86_64.tar.gz" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -O /root/tools/exercism.tar.gz -qi -
mkdir -p /root/tools/exercism
tar -xzvf /root/tools/exercism.tar.gz -C /root/tools/exercism

echo https://exercism.io/my/settings
read -s -p "Enter your exercism token:" exercism_token
exercism configure --token=$exercism_token
