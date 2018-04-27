#!/bin/bash

sudo apt update && sudo apt install zsh -y && chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i 's/robbyrussell/af-magic/g' ~/.zshrc
zsh
#Set git environment
#git config --global user.email "elsvent@gmail.com"
#git config --global user.name "Elsvent Hong"

echo "Configuration files has been installed."
