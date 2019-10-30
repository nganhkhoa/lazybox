# git config
read -p "Enter your git name: " git_name
echo $git_name
git config --global user.name "${git_name}"

read -p "Enter your git email: " git_email
echo $git_email
git config --global user.email "${git_email}"

echo https://exercism.io/my/settings
read -p "Enter your exercism token: " exercism_token
exercism configure --token=$exercism_token
