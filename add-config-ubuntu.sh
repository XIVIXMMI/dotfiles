#!/bin/bash
# File: ~/dotfiles/add-config-ubuntu.sh

# Check input arguments
if [ $# -lt 1 ]; then
  echo "Usage: $0 <config_file_path1> [<config_file_path2> ...]"
  exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STOW_DIR="$DOTFILES_DIR/ubuntu"

# Process each config file
for CONFIG_PATH in "$@"; do
  echo "Processing: $CONFIG_PATH"

  # Check the file exists
  if [ ! -e "$CONFIG_PATH" ]; then
    echo "Warning: $CONFIG_PATH does not exist, skipping."
    continue
  fi

  # Path relative to $HOME
  REL_PATH="${CONFIG_PATH/#$HOME\//}"

  # Create the destination directory inside the stow directory
  mkdir -p "$STOW_DIR/$(dirname "$REL_PATH")"

  # Copy the file into the stow directory
  cp -r "$CONFIG_PATH" "$STOW_DIR/$REL_PATH"

  # Back up the original config file
  mv "$CONFIG_PATH" "$CONFIG_PATH.bak"

  echo "✓ Added $CONFIG_PATH to stow."
done

# Restow everything
cd "$DOTFILES_DIR"
stow -R -t ~ ubuntu

echo "Done! Symlinks created for all config files."
