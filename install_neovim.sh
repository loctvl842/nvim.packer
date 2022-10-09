#!/bin/bash

git clone https://github.com/neovim/neovim.git ~/.config/nvim/neovim

cd ~/.config/nvim/neovim

# git reset --hard d15a66d80336ff3f6c69a0eff4c17c83a84d44c9
git reset --hard d367ed9b23d481998d297d812f54b950e5511c24

sudo rm /usr/local/bin/nvim
sudo rm -r /usr/local/share/nvim/

make CMAKE_BUILD_TYPE=RelWithDebInfo

sudo make install

sudo rm -rf ~/.config/nvim/neovim
