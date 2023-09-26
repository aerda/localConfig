#!/bin/bash

# Check if the ~/.config/nvim directory exists, create it if not
if [ ! -d "$HOME/.config/nvim" ]; then
  mkdir -p "$HOME/.config/nvim"
fi

# Define the source and destination paths
source_path="$(pwd)/init.vim"
destination_path="$HOME/.config/nvim/init.vim"

# Create a symbolic link
ln -sf "$source_path" "$destination_path"

# Check if the symbolic link was successfully created
if [ -L "$destination_path" ]; then
  echo "Symbolic link created from init.vim to $destination_path"
else
  echo "Failed to create the symbolic link"
fi

