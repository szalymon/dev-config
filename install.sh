#!/bin/bash

if [ ! -d ~/.tmux/plugins/tpm ]; then
  echo "Install tmux plugin manager"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "tmux plugin manager already exists!"
fi

echo "Delete neovim config"
rm -fr ~/.config/nvim
echo "Create neovim config"
cp -r ./nvim ~/.config/


echo "Delete tmux config"
rm ~/.tmux.conf
echo "Create tmux config"
cp ./tmux/.tmux.conf ~/

echo "Execute [prefix + I] to install tmux plugins"


