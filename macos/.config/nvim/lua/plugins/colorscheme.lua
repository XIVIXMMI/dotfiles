return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000, -- Load trước các plugin khác
    config = function()
      require("cyberdream").setup({
        variant = "default", -- Chọn biến thể màu sắc
        transparent = true, -- Nền trong suốt
        saturation = 1, -- Độ bão hòa màu (0 - 1)
        italic_comments = true, -- Comment in nghiêng
        hide_fillchars = false, -- Hiện các ký tự fill (như dấu `~`)
        borderless_pickers = false, -- Picker không viền
        terminal_colors = true, -- Màu sắc cho terminal
        cache = false, -- Tắt cache (dùng khi dev theme)

        highlights = { -- Tuỳ chỉnh highlight
          Comment = { fg = "#696969", bg = "NONE", italic = true },
          Normal = { bg = "NONE" },
          NormalFloat = { bg = "NONE" },
        },

        colors = { -- Tuỳ chỉnh màu sắc
          bg = "#000000",
          green = "#00ff00",
          magenta = "#ff00ff",
        },

        extensions = { -- Hỗ trợ các plugin khác
          telescope = true,
          notify = true,
          mini = true,
        },
      })
      vim.cmd.colorscheme("cyberdream") -- Áp dụng theme
    end,
  },
}
