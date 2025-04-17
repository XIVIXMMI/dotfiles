return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- Hiển thị tất cả file & thư mục ẩn
        hide_dotfiles = false, -- Hiển thị file bắt đầu bằng `.`
        hide_gitignored = false, -- Hiển thị cả file bị ignore trong `.gitignore`
      },
    },
  },
}
