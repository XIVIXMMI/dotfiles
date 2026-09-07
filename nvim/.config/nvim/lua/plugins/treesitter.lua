return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = { "rust", "javascript", "html", "css", "toml", "json", "java" },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
