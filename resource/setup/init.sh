# quick load when run 'docker exec' with bash -l
#     because other programs will not load ~/.bashrc
#     so we work around by exec `bash -l -c ""`
#     so that it will load /etc/profile.d/*
sudo ln ~/.bashrc /etc/profile.d/env.sh

# neovim setup
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip install --user pynvim
# install plugins
nvim +PlugInstall +UpdateRemotePlugins +qa

# git config
read -p "Enter your git name: " git_name
git config --global user.name "${git_name}"

read -p "Enter your git email: " git_email
git config --global user.email "${git_email}"

echo https://exercism.io/my/settings
read -p "Enter your exercism token: " exercism_token
exercism configure --token=$exercism_token

echo https://wakatime.com/settings/account
read -p "Enter your wakatime token: " wakatime_token
echo -e \
  "\n" \
  "[settings]\n" \
  "api_key = ${wakatime_token}" \
  > .wakatime.cfg
