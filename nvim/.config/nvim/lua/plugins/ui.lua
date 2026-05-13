return {
  { "nvim-tree/nvim-web-devicons" },

  {
    "nvim-tree/nvim-tree.lua",
    keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>" } },
    config = function()
      require("nvim-tree").setup()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>" },
    },
    config = function()
      require("telescope").setup()
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  {
    "folke/trouble.nvim",
    keys = { { "<leader>xx", "<cmd>TroubleToggle<cr>" } },
    config = function()
      require("trouble").setup()
    end,
  },
}
