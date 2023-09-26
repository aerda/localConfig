#!/bin/bash

# Check if the ~/.config/nvim directory exists, create it if not
if [ ! -d "$HOME/.config/nvim" ]; then
  mkdir -p "$HOME/.config/nvim"
fi

# Define the source and destination paths
source_path_init="$(pwd)/init.vim"
destination_path_init="$HOME/.config/nvim/init.vim"

source_path_coc="$(pwd)/coc-settings.json"
destination_path_coc="$HOME/.config/nvim/coc-settings.json"

# Create a symbolic link
ln -sf "$source_path_init" "$destination_path_init"

# Check if the symbolic link was successfully created
if [ -L "$source_path_init" ]; then
  echo "Symbolic link created from init.vim to $destination_path_init"
else
  echo "Failed to create the symbolic link"
fi

# Create a symbolic link
ln -sf "$source_path_coc" "$destination_path_coc"

# Check if the symbolic link was successfully created
if [ -L "$source_path_coc" ]; then
  echo "Symbolic link created from init.vim to $destination_path_coc"
else
  echo "Failed to create the symbolic link"
fi
