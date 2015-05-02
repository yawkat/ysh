#!/usr/bin/env bash

set -e

echo "Cloning..."
mkdir -p ~/.config
cd ~/.config
git clone git@github.com:yawkat/ysh.git

echo "source ~/.config/ysh/ysh.sh" >> ~/.zshrc
