#!/usr/bin/env bash

set -e

echo "Installing..."
mkdir -p ~/.config
cd ~/.config
git clone https://github.com/yawkat/ysh.git

echo "source ~/.config/ysh/ysh.sh" >> ~/.zshrc

touch ~/.config/ysh/.last-update
