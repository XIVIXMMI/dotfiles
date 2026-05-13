return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          rust = { "rustfmt" },
          javascript = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          json = { "prettier" },
        },
        format_on_save = { timeout_ms = 2000, lsp_fallback = true },
      })
    end,
  },
}
