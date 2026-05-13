return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = { "rust", "javascript", "html", "css", "toml", "json" },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
