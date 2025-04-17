#!/bin/bash
# Tên file: ~/dotfiles/add-configs.sh

# Kiểm tra tham số đầu vào
if [ $# -lt 1 ]; then
  echo "Sử dụng: $0 <đường_dẫn_file_config1> [<đường_dẫn_file_config2> ...]"
  exit 1
fi

STOW_DIR="$HOME/dotfiles/macos"

# Xử lý từng file cấu hình
for CONFIG_PATH in "$@"; do
  echo "Đang xử lý: $CONFIG_PATH"

  # Kiểm tra file tồn tại
  if [ ! -e "$CONFIG_PATH" ]; then
    echo "Cảnh báo: $CONFIG_PATH không tồn tại, bỏ qua."
    continue
  fi

  # Đường dẫn tương đối từ $HOME
  REL_PATH="${CONFIG_PATH/#$HOME\//}"

  # Tạo thư mục đích trong thư mục stow
  mkdir -p "$STOW_DIR/$(dirname "$REL_PATH")"

  # Copy file vào thư mục stow
  cp -r "$CONFIG_PATH" "$STOW_DIR/$REL_PATH"

  # Backup file cấu hình gốc
  mv "$CONFIG_PATH" "$CONFIG_PATH.bak"

  echo "✓ Đã thêm $CONFIG_PATH vào stow."
done

# Restow tất cả
cd "$HOME/dotfiles"
stow -R -t ~ macos

echo "Hoàn tất! Đã tạo symlinks cho tất cả các file cấu hình."
