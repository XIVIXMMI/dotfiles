return {

  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = "rust", -- loads only for .rs files
    init = function()
      vim.g.rustaceanvim = {
        tools = { enable_clippy = true },
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              checkOnSave = { command = "clippy" },
            },
          },
        },
      }
    end,
  },
}
