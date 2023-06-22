#!/bin/bash


echo "Delete neovim config"
rm -fr ~/.config/nvim
echo "Create neovim config"
cp -r ./nvim ~/.config/


echo "Delete tmux config"
rm ~/.tmux.conf
echo "Create tmux config"
cp ./tmux/.tmux.conf ~/



