#!/bin/bash

# Function to check if a program is installed
check_installed() {
  command -v "$1" >/dev/null 2>&1
}

# Variables to store user responses
install_brew=" "
install_nvim=" "
install_zsh=" "
install_p10k=" "
install_scm_breeze=" "

# Step 1: Check and install Homebrew
if ! check_installed "brew"; then
  read -p "Homebrew is not installed. Do you want to install it? (y/n): " install_brew
  if [ "$install_brew" = "y" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
fi

# Step 2: Check and install Neovim
if ! check_installed "nvim"; then
  read -p "Neovim is not installed. Do you want to install it? (y/n): " install_nvim
  if [ "$install_nvim" = "y" ]; then
    brew install neovim
  fi
fi

# Step 3: Check and install Zsh
if ! check_installed "zsh"; then
  read -p "Zsh is not installed. Do you want to install it? (y/n): " install_zsh
  if [ "$install_zsh" = "y" ]; then
    brew install zsh
    # You can optionally set Zsh as the default shell here
    # chsh -s /usr/local/bin/zsh
  fi
fi

# Step 4: Install Powerlevel10k for Zsh
if ! check_installed "p10k"; then
  read -p "Powerlevel10k is not installed. Do you want to install it for Zsh? (y/n): " install_p10k
  if [ "$install_p10k" = "y" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
    echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
  fi
fi

# Step 5: Install SCM Breeze
if [ ! -d "$HOME/.scm_breeze" ]; then
  read -p "SCM Breeze is not installed. Do you want to install it? (y/n): " install_scm_breeze
  if [ "$install_scm_breeze" = "y" ]; then
    git clone git://github.com/ndbroadbent/scm_breeze.git ~/.scm_breeze
    ~/.scm_breeze/install.sh
  fi
fi

echo "All installations and checks completed."

