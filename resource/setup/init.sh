# quick load when run 'docker exec' with bash -l
#     because other programs will not load ~/.bashrc
#     so we work around by exec `bash -l -c ""`
#     so that it will load /etc/profile.d/*
sudo ln ~/.bashrc /etc/profile.d/env.sh

# because pip could conflict with python-xxx packages
# we install everything in user space
pip2 install --user pwntools PyCryptodome z3-solver numpy distorm3
pip2 install --user ~/tools/volatility # because volatility requires distorm3
pip install --user coconut PyCryptodome z3-solver numpy unp pynvim

# neovim setup
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --headless +PlugInstall +UpdateRemotePlugins +qa
echo ''

# git config
read -p "Enter your git name: " git_name
git config --global user.name "${git_name}"
read -p "Enter your git email: " git_email
git config --global user.email "${git_email}"

# exercism
echo https://exercism.io/my/settings
read -p "Enter your exercism token: " exercism_token
exercism configure --token=$exercism_token

# wakatime
echo https://wakatime.com/settings/account
read -p "Enter your wakatime token: " wakatime_token
echo -e \
  "\n" \
  "[settings]\n" \
  "api_key = ${wakatime_token}" \
  > .wakatime.cfg
