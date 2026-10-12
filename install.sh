#!/bin/bash

# absolute path of this repo, so the symlinks work regardless of the current directory
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -d ~/.tmux/plugins/tpm ]; then
  echo "Install tmux plugin manager"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "tmux plugin manager already exists!"
fi

echo "Delete neovim config"
rm -fr ~/.config/nvim
echo "Link neovim config"
mkdir -p ~/.config
ln -s "$REPO_DIR/nvim" ~/.config/nvim

echo "Delete tmux config"
rm -f ~/.tmux.conf
echo "Link tmux config"
ln -s "$REPO_DIR/tmux/.tmux.conf" ~/.tmux.conf

echo "Execute [prefix + I] to install tmux plugins"
