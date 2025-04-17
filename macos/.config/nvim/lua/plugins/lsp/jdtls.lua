return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      jdtls = {
        init_options = {
          bundles = {
            vim.fn.glob("~/.m2/repository/org/projectlombok/lombok/1.18.28/lombok.jar", true),
          },
        },
      },
    },
  },
}
